IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Voters_Fields := MODULE
 
EXPORT NumFields := 213;
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','poliparty_mapped','phone','work_phone','other_phone','active_status','active_status_mapped','votefiller2','active_other','voterstatus','voterstatus_mapped','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','poliparty_mapped','phone','work_phone','other_phone','active_status','active_status_mapped','votefiller2','active_other','voterstatus','voterstatus_mapped','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'date_first_seen' => 1,'date_last_seen' => 2,'score' => 3,'best_ssn' => 4,'did_out' => 5,'source' => 6,'file_id' => 7,'vendor_id' => 8,'source_state' => 9,'source_code' => 10,'file_acquired_date' => 11,'_use' => 12,'title_in' => 13,'lname_in' => 14,'fname_in' => 15,'mname_in' => 16,'maiden_prior' => 17,'name_suffix_in' => 18,'votefiller' => 19,'source_voterid' => 20,'dob' => 21,'agecat' => 22,'headhousehold' => 23,'place_of_birth' => 24,'occupation' => 25,'maiden_name' => 26,'motorvoterid' => 27,'regsource' => 28,'regdate' => 29,'race' => 30,'gender' => 31,'poliparty' => 32,'poliparty_mapped' => 33,'phone' => 34,'work_phone' => 35,'other_phone' => 36,'active_status' => 37,'active_status_mapped' => 38,'votefiller2' => 39,'active_other' => 40,'voterstatus' => 41,'voterstatus_mapped' => 42,'resaddr1' => 43,'resaddr2' => 44,'res_city' => 45,'res_state' => 46,'res_zip' => 47,'res_county' => 48,'mail_addr1' => 49,'mail_addr2' => 50,'mail_city' => 51,'mail_state' => 52,'mail_zip' => 53,'mail_county' => 54,'addr_filler1' => 55,'addr_filler2' => 56,'city_filler' => 57,'state_filler' => 58,'zip_filler' => 59,'county_filler' => 60,'towncode' => 61,'distcode' => 62,'countycode' => 63,'schoolcode' => 64,'cityinout' => 65,'spec_dist1' => 66,'spec_dist2' => 67,'precinct1' => 68,'precinct2' => 69,'precinct3' => 70,'villageprecinct' => 71,'schoolprecinct' => 72,'ward' => 73,'precinct_citytown' => 74,'ancsmdindc' => 75,'citycouncildist' => 76,'countycommdist' => 77,'statehouse' => 78,'statesenate' => 79,'ushouse' => 80,'elemschooldist' => 81,'schooldist' => 82,'schoolfiller' => 83,'commcolldist' => 84,'dist_filler' => 85,'municipal' => 86,'villagedist' => 87,'policejury' => 88,'policedist' => 89,'publicservcomm' => 90,'rescue' => 91,'fire' => 92,'sanitary' => 93,'sewerdist' => 94,'waterdist' => 95,'mosquitodist' => 96,'taxdist' => 97,'supremecourt' => 98,'justiceofpeace' => 99,'judicialdist' => 100,'superiorctdist' => 101,'appealsct' => 102,'courtfiller' => 103,'contributorparty' => 104,'recptparty' => 105,'dateofcontr' => 106,'dollaramt' => 107,'officecontto' => 108,'cumuldollaramt' => 109,'contfiller1' => 110,'contfiller2' => 111,'conttype' => 112,'contfiller3' => 113,'primary02' => 114,'special02' => 115,'other02' => 116,'special202' => 117,'general02' => 118,'primary01' => 119,'special01' => 120,'other01' => 121,'special201' => 122,'general01' => 123,'pres00' => 124,'primary00' => 125,'special00' => 126,'other00' => 127,'special200' => 128,'general00' => 129,'primary99' => 130,'special99' => 131,'other99' => 132,'special299' => 133,'general99' => 134,'primary98' => 135,'special98' => 136,'other98' => 137,'special298' => 138,'general98' => 139,'primary97' => 140,'special97' => 141,'other97' => 142,'special297' => 143,'general97' => 144,'pres96' => 145,'primary96' => 146,'special96' => 147,'other96' => 148,'special296' => 149,'general96' => 150,'lastdayvote' => 151,'title' => 152,'fname' => 153,'mname' => 154,'lname' => 155,'name_suffix' => 156,'score_on_input' => 157,'prim_range' => 158,'predir' => 159,'prim_name' => 160,'suffix' => 161,'postdir' => 162,'unit_desig' => 163,'sec_range' => 164,'p_city_name' => 165,'city_name' => 166,'st' => 167,'zip' => 168,'zip4' => 169,'cart' => 170,'cr_sort_sz' => 171,'lot' => 172,'lot_order' => 173,'dpbc' => 174,'chk_digit' => 175,'record_type' => 176,'ace_fips_st' => 177,'county' => 178,'county_name' => 179,'geo_lat' => 180,'geo_long' => 181,'msa' => 182,'geo_blk' => 183,'geo_match' => 184,'err_stat' => 185,'mail_prim_range' => 186,'mail_predir' => 187,'mail_prim_name' => 188,'mail_addr_suffix' => 189,'mail_postdir' => 190,'mail_unit_desig' => 191,'mail_sec_range' => 192,'mail_p_city_name' => 193,'mail_v_city_name' => 194,'mail_st' => 195,'mail_ace_zip' => 196,'mail_zip4' => 197,'mail_cart' => 198,'mail_cr_sort_sz' => 199,'mail_lot' => 200,'mail_lot_order' => 201,'mail_dpbc' => 202,'mail_chk_digit' => 203,'mail_record_type' => 204,'mail_ace_fips_st' => 205,'mail_fipscounty' => 206,'mail_geo_lat' => 207,'mail_geo_long' => 208,'mail_msa' => 209,'mail_geo_blk' => 210,'mail_geo_match' => 211,'mail_err_stat' => 212,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
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
 
EXPORT Make_vendor_id(SALT311.StrType s0) := s0;
EXPORT InValid_vendor_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_name_suffix_in(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_name_suffix_in(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_name_suffix_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_regsource(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_regsource(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_regsource(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
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
 
EXPORT Make_poliparty_mapped(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_poliparty_mapped(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_poliparty_mapped(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
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
 
EXPORT Make_active_status_mapped(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_active_status_mapped(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_active_status_mapped(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_votefiller2(SALT311.StrType s0) := s0;
EXPORT InValid_votefiller2(SALT311.StrType s) := 0;
EXPORT InValidMessage_votefiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_active_other(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_active_other(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_active_other(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_voterstatus(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_voterstatus(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_voterstatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_voterstatus_mapped(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_voterstatus_mapped(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_voterstatus_mapped(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_res_county(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_res_county(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_res_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_addr1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_addr1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_addr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_addr2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_addr2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_addr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_mail_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_mail_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_mail_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_mail_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mail_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mail_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_addr_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_addr_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_addr_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_city_filler(SALT311.StrType s0) := s0;
EXPORT InValid_city_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_state_filler(SALT311.StrType s0) := s0;
EXPORT InValid_state_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_state_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_zip_filler(SALT311.StrType s0) := s0;
EXPORT InValid_zip_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_county_filler(SALT311.StrType s0) := s0;
EXPORT InValid_county_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_county_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_towncode(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_towncode(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_towncode(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_distcode(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_distcode(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_distcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_countycode(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_countycode(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_countycode(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_schoolcode(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_schoolcode(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_schoolcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cityinout(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cityinout(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cityinout(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_spec_dist1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_spec_dist1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_spec_dist1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_spec_dist2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_spec_dist2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_spec_dist2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_precinct1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_precinct1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_precinct1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_precinct2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_precinct2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_precinct2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_precinct3(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_precinct3(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_precinct3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_villageprecinct(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_villageprecinct(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_villageprecinct(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_schoolprecinct(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_schoolprecinct(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_schoolprecinct(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_ward(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_ward(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_ward(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_precinct_citytown(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_precinct_citytown(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_precinct_citytown(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_ancsmdindc(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_ancsmdindc(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_ancsmdindc(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_citycouncildist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_citycouncildist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_citycouncildist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_countycommdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_countycommdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_countycommdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_statehouse(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_statehouse(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_statehouse(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_statesenate(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_statesenate(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_statesenate(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_ushouse(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_ushouse(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_ushouse(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_elemschooldist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_elemschooldist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_elemschooldist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_schooldist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_schooldist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_schooldist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_schoolfiller(SALT311.StrType s0) := s0;
EXPORT InValid_schoolfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_schoolfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_commcolldist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_commcolldist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_commcolldist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_dist_filler(SALT311.StrType s0) := s0;
EXPORT InValid_dist_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_dist_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_municipal(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_municipal(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_municipal(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_villagedist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_villagedist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_villagedist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_policejury(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_policejury(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_policejury(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_policedist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_policedist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_policedist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_publicservcomm(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_publicservcomm(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_publicservcomm(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_rescue(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rescue(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rescue(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fire(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fire(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fire(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sanitary(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sanitary(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sanitary(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sewerdist(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sewerdist(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sewerdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_waterdist(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_waterdist(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_waterdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mosquitodist(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mosquitodist(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mosquitodist(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_taxdist(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_taxdist(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_taxdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_supremecourt(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_supremecourt(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_supremecourt(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_justiceofpeace(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_justiceofpeace(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_justiceofpeace(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_judicialdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_judicialdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_judicialdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_superiorctdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_superiorctdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_superiorctdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_appealsct(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_appealsct(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_appealsct(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_courtfiller(SALT311.StrType s0) := s0;
EXPORT InValid_courtfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_contributorparty(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contributorparty(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contributorparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_recptparty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_recptparty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_recptparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dateofcontr(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateofcontr(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateofcontr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dollaramt(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dollaramt(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dollaramt(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_officecontto(SALT311.StrType s0) := s0;
EXPORT InValid_officecontto(SALT311.StrType s) := 0;
EXPORT InValidMessage_officecontto(UNSIGNED1 wh) := '';
 
EXPORT Make_cumuldollaramt(SALT311.StrType s0) := s0;
EXPORT InValid_cumuldollaramt(SALT311.StrType s) := 0;
EXPORT InValidMessage_cumuldollaramt(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller1(SALT311.StrType s0) := s0;
EXPORT InValid_contfiller1(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfiller1(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller2(SALT311.StrType s0) := s0;
EXPORT InValid_contfiller2(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_conttype(SALT311.StrType s0) := s0;
EXPORT InValid_conttype(SALT311.StrType s) := 0;
EXPORT InValidMessage_conttype(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller3(SALT311.StrType s0) := s0;
EXPORT InValid_contfiller3(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfiller3(UNSIGNED1 wh) := '';
 
EXPORT Make_primary02(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary02(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary02(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special02(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special02(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special02(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other02(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other02(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other02(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special202(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special202(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special202(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general02(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general02(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general02(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary01(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary01(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary01(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special01(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special01(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special01(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other01(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other01(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other01(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special201(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special201(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special201(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general01(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general01(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general01(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_pres00(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_pres00(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_pres00(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary00(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary00(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary00(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special00(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special00(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special00(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other00(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other00(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other00(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special200(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special200(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special200(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general00(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general00(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general00(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary99(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary99(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary99(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special99(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special99(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special99(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other99(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other99(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other99(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special299(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special299(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special299(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general99(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general99(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general99(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary98(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary98(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary98(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special98(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special98(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special98(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other98(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other98(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other98(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special298(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special298(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special298(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general98(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general98(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general98(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary97(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary97(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary97(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special97(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special97(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special97(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other97(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other97(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other97(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special297(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special297(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special297(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general97(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general97(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general97(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_pres96(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_pres96(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_pres96(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primary96(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primary96(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primary96(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special96(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special96(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special96(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_other96(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_other96(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_other96(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_special296(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_special296(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_special296(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_general96(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_general96(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_general96(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lastdayvote(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_lastdayvote(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_lastdayvote(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
 
EXPORT Make_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_mail_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mail_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
    BOOLEAN Diff_poliparty_mapped;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_other_phone;
    BOOLEAN Diff_active_status;
    BOOLEAN Diff_active_status_mapped;
    BOOLEAN Diff_votefiller2;
    BOOLEAN Diff_active_other;
    BOOLEAN Diff_voterstatus;
    BOOLEAN Diff_voterstatus_mapped;
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
    BOOLEAN Diff_addr_filler1;
    BOOLEAN Diff_addr_filler2;
    BOOLEAN Diff_city_filler;
    BOOLEAN Diff_state_filler;
    BOOLEAN Diff_zip_filler;
    BOOLEAN Diff_county_filler;
    BOOLEAN Diff_towncode;
    BOOLEAN Diff_distcode;
    BOOLEAN Diff_countycode;
    BOOLEAN Diff_schoolcode;
    BOOLEAN Diff_cityinout;
    BOOLEAN Diff_spec_dist1;
    BOOLEAN Diff_spec_dist2;
    BOOLEAN Diff_precinct1;
    BOOLEAN Diff_precinct2;
    BOOLEAN Diff_precinct3;
    BOOLEAN Diff_villageprecinct;
    BOOLEAN Diff_schoolprecinct;
    BOOLEAN Diff_ward;
    BOOLEAN Diff_precinct_citytown;
    BOOLEAN Diff_ancsmdindc;
    BOOLEAN Diff_citycouncildist;
    BOOLEAN Diff_countycommdist;
    BOOLEAN Diff_statehouse;
    BOOLEAN Diff_statesenate;
    BOOLEAN Diff_ushouse;
    BOOLEAN Diff_elemschooldist;
    BOOLEAN Diff_schooldist;
    BOOLEAN Diff_schoolfiller;
    BOOLEAN Diff_commcolldist;
    BOOLEAN Diff_dist_filler;
    BOOLEAN Diff_municipal;
    BOOLEAN Diff_villagedist;
    BOOLEAN Diff_policejury;
    BOOLEAN Diff_policedist;
    BOOLEAN Diff_publicservcomm;
    BOOLEAN Diff_rescue;
    BOOLEAN Diff_fire;
    BOOLEAN Diff_sanitary;
    BOOLEAN Diff_sewerdist;
    BOOLEAN Diff_waterdist;
    BOOLEAN Diff_mosquitodist;
    BOOLEAN Diff_taxdist;
    BOOLEAN Diff_supremecourt;
    BOOLEAN Diff_justiceofpeace;
    BOOLEAN Diff_judicialdist;
    BOOLEAN Diff_superiorctdist;
    BOOLEAN Diff_appealsct;
    BOOLEAN Diff_courtfiller;
    BOOLEAN Diff_contributorparty;
    BOOLEAN Diff_recptparty;
    BOOLEAN Diff_dateofcontr;
    BOOLEAN Diff_dollaramt;
    BOOLEAN Diff_officecontto;
    BOOLEAN Diff_cumuldollaramt;
    BOOLEAN Diff_contfiller1;
    BOOLEAN Diff_contfiller2;
    BOOLEAN Diff_conttype;
    BOOLEAN Diff_contfiller3;
    BOOLEAN Diff_primary02;
    BOOLEAN Diff_special02;
    BOOLEAN Diff_other02;
    BOOLEAN Diff_special202;
    BOOLEAN Diff_general02;
    BOOLEAN Diff_primary01;
    BOOLEAN Diff_special01;
    BOOLEAN Diff_other01;
    BOOLEAN Diff_special201;
    BOOLEAN Diff_general01;
    BOOLEAN Diff_pres00;
    BOOLEAN Diff_primary00;
    BOOLEAN Diff_special00;
    BOOLEAN Diff_other00;
    BOOLEAN Diff_special200;
    BOOLEAN Diff_general00;
    BOOLEAN Diff_primary99;
    BOOLEAN Diff_special99;
    BOOLEAN Diff_other99;
    BOOLEAN Diff_special299;
    BOOLEAN Diff_general99;
    BOOLEAN Diff_primary98;
    BOOLEAN Diff_special98;
    BOOLEAN Diff_other98;
    BOOLEAN Diff_special298;
    BOOLEAN Diff_general98;
    BOOLEAN Diff_primary97;
    BOOLEAN Diff_special97;
    BOOLEAN Diff_other97;
    BOOLEAN Diff_special297;
    BOOLEAN Diff_general97;
    BOOLEAN Diff_pres96;
    BOOLEAN Diff_primary96;
    BOOLEAN Diff_special96;
    BOOLEAN Diff_other96;
    BOOLEAN Diff_special296;
    BOOLEAN Diff_general96;
    BOOLEAN Diff_lastdayvote;
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
    SELF.Diff_poliparty_mapped := le.poliparty_mapped <> ri.poliparty_mapped;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_other_phone := le.other_phone <> ri.other_phone;
    SELF.Diff_active_status := le.active_status <> ri.active_status;
    SELF.Diff_active_status_mapped := le.active_status_mapped <> ri.active_status_mapped;
    SELF.Diff_votefiller2 := le.votefiller2 <> ri.votefiller2;
    SELF.Diff_active_other := le.active_other <> ri.active_other;
    SELF.Diff_voterstatus := le.voterstatus <> ri.voterstatus;
    SELF.Diff_voterstatus_mapped := le.voterstatus_mapped <> ri.voterstatus_mapped;
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
    SELF.Diff_addr_filler1 := le.addr_filler1 <> ri.addr_filler1;
    SELF.Diff_addr_filler2 := le.addr_filler2 <> ri.addr_filler2;
    SELF.Diff_city_filler := le.city_filler <> ri.city_filler;
    SELF.Diff_state_filler := le.state_filler <> ri.state_filler;
    SELF.Diff_zip_filler := le.zip_filler <> ri.zip_filler;
    SELF.Diff_county_filler := le.county_filler <> ri.county_filler;
    SELF.Diff_towncode := le.towncode <> ri.towncode;
    SELF.Diff_distcode := le.distcode <> ri.distcode;
    SELF.Diff_countycode := le.countycode <> ri.countycode;
    SELF.Diff_schoolcode := le.schoolcode <> ri.schoolcode;
    SELF.Diff_cityinout := le.cityinout <> ri.cityinout;
    SELF.Diff_spec_dist1 := le.spec_dist1 <> ri.spec_dist1;
    SELF.Diff_spec_dist2 := le.spec_dist2 <> ri.spec_dist2;
    SELF.Diff_precinct1 := le.precinct1 <> ri.precinct1;
    SELF.Diff_precinct2 := le.precinct2 <> ri.precinct2;
    SELF.Diff_precinct3 := le.precinct3 <> ri.precinct3;
    SELF.Diff_villageprecinct := le.villageprecinct <> ri.villageprecinct;
    SELF.Diff_schoolprecinct := le.schoolprecinct <> ri.schoolprecinct;
    SELF.Diff_ward := le.ward <> ri.ward;
    SELF.Diff_precinct_citytown := le.precinct_citytown <> ri.precinct_citytown;
    SELF.Diff_ancsmdindc := le.ancsmdindc <> ri.ancsmdindc;
    SELF.Diff_citycouncildist := le.citycouncildist <> ri.citycouncildist;
    SELF.Diff_countycommdist := le.countycommdist <> ri.countycommdist;
    SELF.Diff_statehouse := le.statehouse <> ri.statehouse;
    SELF.Diff_statesenate := le.statesenate <> ri.statesenate;
    SELF.Diff_ushouse := le.ushouse <> ri.ushouse;
    SELF.Diff_elemschooldist := le.elemschooldist <> ri.elemschooldist;
    SELF.Diff_schooldist := le.schooldist <> ri.schooldist;
    SELF.Diff_schoolfiller := le.schoolfiller <> ri.schoolfiller;
    SELF.Diff_commcolldist := le.commcolldist <> ri.commcolldist;
    SELF.Diff_dist_filler := le.dist_filler <> ri.dist_filler;
    SELF.Diff_municipal := le.municipal <> ri.municipal;
    SELF.Diff_villagedist := le.villagedist <> ri.villagedist;
    SELF.Diff_policejury := le.policejury <> ri.policejury;
    SELF.Diff_policedist := le.policedist <> ri.policedist;
    SELF.Diff_publicservcomm := le.publicservcomm <> ri.publicservcomm;
    SELF.Diff_rescue := le.rescue <> ri.rescue;
    SELF.Diff_fire := le.fire <> ri.fire;
    SELF.Diff_sanitary := le.sanitary <> ri.sanitary;
    SELF.Diff_sewerdist := le.sewerdist <> ri.sewerdist;
    SELF.Diff_waterdist := le.waterdist <> ri.waterdist;
    SELF.Diff_mosquitodist := le.mosquitodist <> ri.mosquitodist;
    SELF.Diff_taxdist := le.taxdist <> ri.taxdist;
    SELF.Diff_supremecourt := le.supremecourt <> ri.supremecourt;
    SELF.Diff_justiceofpeace := le.justiceofpeace <> ri.justiceofpeace;
    SELF.Diff_judicialdist := le.judicialdist <> ri.judicialdist;
    SELF.Diff_superiorctdist := le.superiorctdist <> ri.superiorctdist;
    SELF.Diff_appealsct := le.appealsct <> ri.appealsct;
    SELF.Diff_courtfiller := le.courtfiller <> ri.courtfiller;
    SELF.Diff_contributorparty := le.contributorparty <> ri.contributorparty;
    SELF.Diff_recptparty := le.recptparty <> ri.recptparty;
    SELF.Diff_dateofcontr := le.dateofcontr <> ri.dateofcontr;
    SELF.Diff_dollaramt := le.dollaramt <> ri.dollaramt;
    SELF.Diff_officecontto := le.officecontto <> ri.officecontto;
    SELF.Diff_cumuldollaramt := le.cumuldollaramt <> ri.cumuldollaramt;
    SELF.Diff_contfiller1 := le.contfiller1 <> ri.contfiller1;
    SELF.Diff_contfiller2 := le.contfiller2 <> ri.contfiller2;
    SELF.Diff_conttype := le.conttype <> ri.conttype;
    SELF.Diff_contfiller3 := le.contfiller3 <> ri.contfiller3;
    SELF.Diff_primary02 := le.primary02 <> ri.primary02;
    SELF.Diff_special02 := le.special02 <> ri.special02;
    SELF.Diff_other02 := le.other02 <> ri.other02;
    SELF.Diff_special202 := le.special202 <> ri.special202;
    SELF.Diff_general02 := le.general02 <> ri.general02;
    SELF.Diff_primary01 := le.primary01 <> ri.primary01;
    SELF.Diff_special01 := le.special01 <> ri.special01;
    SELF.Diff_other01 := le.other01 <> ri.other01;
    SELF.Diff_special201 := le.special201 <> ri.special201;
    SELF.Diff_general01 := le.general01 <> ri.general01;
    SELF.Diff_pres00 := le.pres00 <> ri.pres00;
    SELF.Diff_primary00 := le.primary00 <> ri.primary00;
    SELF.Diff_special00 := le.special00 <> ri.special00;
    SELF.Diff_other00 := le.other00 <> ri.other00;
    SELF.Diff_special200 := le.special200 <> ri.special200;
    SELF.Diff_general00 := le.general00 <> ri.general00;
    SELF.Diff_primary99 := le.primary99 <> ri.primary99;
    SELF.Diff_special99 := le.special99 <> ri.special99;
    SELF.Diff_other99 := le.other99 <> ri.other99;
    SELF.Diff_special299 := le.special299 <> ri.special299;
    SELF.Diff_general99 := le.general99 <> ri.general99;
    SELF.Diff_primary98 := le.primary98 <> ri.primary98;
    SELF.Diff_special98 := le.special98 <> ri.special98;
    SELF.Diff_other98 := le.other98 <> ri.other98;
    SELF.Diff_special298 := le.special298 <> ri.special298;
    SELF.Diff_general98 := le.general98 <> ri.general98;
    SELF.Diff_primary97 := le.primary97 <> ri.primary97;
    SELF.Diff_special97 := le.special97 <> ri.special97;
    SELF.Diff_other97 := le.other97 <> ri.other97;
    SELF.Diff_special297 := le.special297 <> ri.special297;
    SELF.Diff_general97 := le.general97 <> ri.general97;
    SELF.Diff_pres96 := le.pres96 <> ri.pres96;
    SELF.Diff_primary96 := le.primary96 <> ri.primary96;
    SELF.Diff_special96 := le.special96 <> ri.special96;
    SELF.Diff_other96 := le.other96 <> ri.other96;
    SELF.Diff_special296 := le.special296 <> ri.special296;
    SELF.Diff_general96 := le.general96 <> ri.general96;
    SELF.Diff_lastdayvote := le.lastdayvote <> ri.lastdayvote;
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
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_did_out,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_file_acquired_date,1,0)+ IF( SELF.Diff__use,1,0)+ IF( SELF.Diff_title_in,1,0)+ IF( SELF.Diff_lname_in,1,0)+ IF( SELF.Diff_fname_in,1,0)+ IF( SELF.Diff_mname_in,1,0)+ IF( SELF.Diff_maiden_prior,1,0)+ IF( SELF.Diff_name_suffix_in,1,0)+ IF( SELF.Diff_votefiller,1,0)+ IF( SELF.Diff_source_voterid,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_agecat,1,0)+ IF( SELF.Diff_headhousehold,1,0)+ IF( SELF.Diff_place_of_birth,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_maiden_name,1,0)+ IF( SELF.Diff_motorvoterid,1,0)+ IF( SELF.Diff_regsource,1,0)+ IF( SELF.Diff_regdate,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_poliparty,1,0)+ IF( SELF.Diff_poliparty_mapped,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_other_phone,1,0)+ IF( SELF.Diff_active_status,1,0)+ IF( SELF.Diff_active_status_mapped,1,0)+ IF( SELF.Diff_votefiller2,1,0)+ IF( SELF.Diff_active_other,1,0)+ IF( SELF.Diff_voterstatus,1,0)+ IF( SELF.Diff_voterstatus_mapped,1,0)+ IF( SELF.Diff_resaddr1,1,0)+ IF( SELF.Diff_resaddr2,1,0)+ IF( SELF.Diff_res_city,1,0)+ IF( SELF.Diff_res_state,1,0)+ IF( SELF.Diff_res_zip,1,0)+ IF( SELF.Diff_res_county,1,0)+ IF( SELF.Diff_mail_addr1,1,0)+ IF( SELF.Diff_mail_addr2,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_addr_filler1,1,0)+ IF( SELF.Diff_addr_filler2,1,0)+ IF( SELF.Diff_city_filler,1,0)+ IF( SELF.Diff_state_filler,1,0)+ IF( SELF.Diff_zip_filler,1,0)+ IF( SELF.Diff_county_filler,1,0)+ IF( SELF.Diff_towncode,1,0)+ IF( SELF.Diff_distcode,1,0)+ IF( SELF.Diff_countycode,1,0)+ IF( SELF.Diff_schoolcode,1,0)+ IF( SELF.Diff_cityinout,1,0)+ IF( SELF.Diff_spec_dist1,1,0)+ IF( SELF.Diff_spec_dist2,1,0)+ IF( SELF.Diff_precinct1,1,0)+ IF( SELF.Diff_precinct2,1,0)+ IF( SELF.Diff_precinct3,1,0)+ IF( SELF.Diff_villageprecinct,1,0)+ IF( SELF.Diff_schoolprecinct,1,0)+ IF( SELF.Diff_ward,1,0)+ IF( SELF.Diff_precinct_citytown,1,0)+ IF( SELF.Diff_ancsmdindc,1,0)+ IF( SELF.Diff_citycouncildist,1,0)+ IF( SELF.Diff_countycommdist,1,0)+ IF( SELF.Diff_statehouse,1,0)+ IF( SELF.Diff_statesenate,1,0)+ IF( SELF.Diff_ushouse,1,0)+ IF( SELF.Diff_elemschooldist,1,0)+ IF( SELF.Diff_schooldist,1,0)+ IF( SELF.Diff_schoolfiller,1,0)+ IF( SELF.Diff_commcolldist,1,0)+ IF( SELF.Diff_dist_filler,1,0)+ IF( SELF.Diff_municipal,1,0)+ IF( SELF.Diff_villagedist,1,0)+ IF( SELF.Diff_policejury,1,0)+ IF( SELF.Diff_policedist,1,0)+ IF( SELF.Diff_publicservcomm,1,0)+ IF( SELF.Diff_rescue,1,0)+ IF( SELF.Diff_fire,1,0)+ IF( SELF.Diff_sanitary,1,0)+ IF( SELF.Diff_sewerdist,1,0)+ IF( SELF.Diff_waterdist,1,0)+ IF( SELF.Diff_mosquitodist,1,0)+ IF( SELF.Diff_taxdist,1,0)+ IF( SELF.Diff_supremecourt,1,0)+ IF( SELF.Diff_justiceofpeace,1,0)+ IF( SELF.Diff_judicialdist,1,0)+ IF( SELF.Diff_superiorctdist,1,0)+ IF( SELF.Diff_appealsct,1,0)+ IF( SELF.Diff_courtfiller,1,0)+ IF( SELF.Diff_contributorparty,1,0)+ IF( SELF.Diff_recptparty,1,0)+ IF( SELF.Diff_dateofcontr,1,0)+ IF( SELF.Diff_dollaramt,1,0)+ IF( SELF.Diff_officecontto,1,0)+ IF( SELF.Diff_cumuldollaramt,1,0)+ IF( SELF.Diff_contfiller1,1,0)+ IF( SELF.Diff_contfiller2,1,0)+ IF( SELF.Diff_conttype,1,0)+ IF( SELF.Diff_contfiller3,1,0)+ IF( SELF.Diff_primary02,1,0)+ IF( SELF.Diff_special02,1,0)+ IF( SELF.Diff_other02,1,0)+ IF( SELF.Diff_special202,1,0)+ IF( SELF.Diff_general02,1,0)+ IF( SELF.Diff_primary01,1,0)+ IF( SELF.Diff_special01,1,0)+ IF( SELF.Diff_other01,1,0)+ IF( SELF.Diff_special201,1,0)+ IF( SELF.Diff_general01,1,0)+ IF( SELF.Diff_pres00,1,0)+ IF( SELF.Diff_primary00,1,0)+ IF( SELF.Diff_special00,1,0)+ IF( SELF.Diff_other00,1,0)+ IF( SELF.Diff_special200,1,0)+ IF( SELF.Diff_general00,1,0)+ IF( SELF.Diff_primary99,1,0)+ IF( SELF.Diff_special99,1,0)+ IF( SELF.Diff_other99,1,0)+ IF( SELF.Diff_special299,1,0)+ IF( SELF.Diff_general99,1,0)+ IF( SELF.Diff_primary98,1,0)+ IF( SELF.Diff_special98,1,0)+ IF( SELF.Diff_other98,1,0)+ IF( SELF.Diff_special298,1,0)+ IF( SELF.Diff_general98,1,0)+ IF( SELF.Diff_primary97,1,0)+ IF( SELF.Diff_special97,1,0)+ IF( SELF.Diff_other97,1,0)+ IF( SELF.Diff_special297,1,0)+ IF( SELF.Diff_general97,1,0)+ IF( SELF.Diff_pres96,1,0)+ IF( SELF.Diff_primary96,1,0)+ IF( SELF.Diff_special96,1,0)+ IF( SELF.Diff_other96,1,0)+ IF( SELF.Diff_special296,1,0)+ IF( SELF.Diff_general96,1,0)+ IF( SELF.Diff_lastdayvote,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_score_on_input,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_ace_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dpbc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_record_type,1,0)+ IF( SELF.Diff_mail_ace_fips_st,1,0)+ IF( SELF.Diff_mail_fipscounty,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0);
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
    Count_Diff_poliparty_mapped := COUNT(GROUP,%Closest%.Diff_poliparty_mapped);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_other_phone := COUNT(GROUP,%Closest%.Diff_other_phone);
    Count_Diff_active_status := COUNT(GROUP,%Closest%.Diff_active_status);
    Count_Diff_active_status_mapped := COUNT(GROUP,%Closest%.Diff_active_status_mapped);
    Count_Diff_votefiller2 := COUNT(GROUP,%Closest%.Diff_votefiller2);
    Count_Diff_active_other := COUNT(GROUP,%Closest%.Diff_active_other);
    Count_Diff_voterstatus := COUNT(GROUP,%Closest%.Diff_voterstatus);
    Count_Diff_voterstatus_mapped := COUNT(GROUP,%Closest%.Diff_voterstatus_mapped);
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
    Count_Diff_addr_filler1 := COUNT(GROUP,%Closest%.Diff_addr_filler1);
    Count_Diff_addr_filler2 := COUNT(GROUP,%Closest%.Diff_addr_filler2);
    Count_Diff_city_filler := COUNT(GROUP,%Closest%.Diff_city_filler);
    Count_Diff_state_filler := COUNT(GROUP,%Closest%.Diff_state_filler);
    Count_Diff_zip_filler := COUNT(GROUP,%Closest%.Diff_zip_filler);
    Count_Diff_county_filler := COUNT(GROUP,%Closest%.Diff_county_filler);
    Count_Diff_towncode := COUNT(GROUP,%Closest%.Diff_towncode);
    Count_Diff_distcode := COUNT(GROUP,%Closest%.Diff_distcode);
    Count_Diff_countycode := COUNT(GROUP,%Closest%.Diff_countycode);
    Count_Diff_schoolcode := COUNT(GROUP,%Closest%.Diff_schoolcode);
    Count_Diff_cityinout := COUNT(GROUP,%Closest%.Diff_cityinout);
    Count_Diff_spec_dist1 := COUNT(GROUP,%Closest%.Diff_spec_dist1);
    Count_Diff_spec_dist2 := COUNT(GROUP,%Closest%.Diff_spec_dist2);
    Count_Diff_precinct1 := COUNT(GROUP,%Closest%.Diff_precinct1);
    Count_Diff_precinct2 := COUNT(GROUP,%Closest%.Diff_precinct2);
    Count_Diff_precinct3 := COUNT(GROUP,%Closest%.Diff_precinct3);
    Count_Diff_villageprecinct := COUNT(GROUP,%Closest%.Diff_villageprecinct);
    Count_Diff_schoolprecinct := COUNT(GROUP,%Closest%.Diff_schoolprecinct);
    Count_Diff_ward := COUNT(GROUP,%Closest%.Diff_ward);
    Count_Diff_precinct_citytown := COUNT(GROUP,%Closest%.Diff_precinct_citytown);
    Count_Diff_ancsmdindc := COUNT(GROUP,%Closest%.Diff_ancsmdindc);
    Count_Diff_citycouncildist := COUNT(GROUP,%Closest%.Diff_citycouncildist);
    Count_Diff_countycommdist := COUNT(GROUP,%Closest%.Diff_countycommdist);
    Count_Diff_statehouse := COUNT(GROUP,%Closest%.Diff_statehouse);
    Count_Diff_statesenate := COUNT(GROUP,%Closest%.Diff_statesenate);
    Count_Diff_ushouse := COUNT(GROUP,%Closest%.Diff_ushouse);
    Count_Diff_elemschooldist := COUNT(GROUP,%Closest%.Diff_elemschooldist);
    Count_Diff_schooldist := COUNT(GROUP,%Closest%.Diff_schooldist);
    Count_Diff_schoolfiller := COUNT(GROUP,%Closest%.Diff_schoolfiller);
    Count_Diff_commcolldist := COUNT(GROUP,%Closest%.Diff_commcolldist);
    Count_Diff_dist_filler := COUNT(GROUP,%Closest%.Diff_dist_filler);
    Count_Diff_municipal := COUNT(GROUP,%Closest%.Diff_municipal);
    Count_Diff_villagedist := COUNT(GROUP,%Closest%.Diff_villagedist);
    Count_Diff_policejury := COUNT(GROUP,%Closest%.Diff_policejury);
    Count_Diff_policedist := COUNT(GROUP,%Closest%.Diff_policedist);
    Count_Diff_publicservcomm := COUNT(GROUP,%Closest%.Diff_publicservcomm);
    Count_Diff_rescue := COUNT(GROUP,%Closest%.Diff_rescue);
    Count_Diff_fire := COUNT(GROUP,%Closest%.Diff_fire);
    Count_Diff_sanitary := COUNT(GROUP,%Closest%.Diff_sanitary);
    Count_Diff_sewerdist := COUNT(GROUP,%Closest%.Diff_sewerdist);
    Count_Diff_waterdist := COUNT(GROUP,%Closest%.Diff_waterdist);
    Count_Diff_mosquitodist := COUNT(GROUP,%Closest%.Diff_mosquitodist);
    Count_Diff_taxdist := COUNT(GROUP,%Closest%.Diff_taxdist);
    Count_Diff_supremecourt := COUNT(GROUP,%Closest%.Diff_supremecourt);
    Count_Diff_justiceofpeace := COUNT(GROUP,%Closest%.Diff_justiceofpeace);
    Count_Diff_judicialdist := COUNT(GROUP,%Closest%.Diff_judicialdist);
    Count_Diff_superiorctdist := COUNT(GROUP,%Closest%.Diff_superiorctdist);
    Count_Diff_appealsct := COUNT(GROUP,%Closest%.Diff_appealsct);
    Count_Diff_courtfiller := COUNT(GROUP,%Closest%.Diff_courtfiller);
    Count_Diff_contributorparty := COUNT(GROUP,%Closest%.Diff_contributorparty);
    Count_Diff_recptparty := COUNT(GROUP,%Closest%.Diff_recptparty);
    Count_Diff_dateofcontr := COUNT(GROUP,%Closest%.Diff_dateofcontr);
    Count_Diff_dollaramt := COUNT(GROUP,%Closest%.Diff_dollaramt);
    Count_Diff_officecontto := COUNT(GROUP,%Closest%.Diff_officecontto);
    Count_Diff_cumuldollaramt := COUNT(GROUP,%Closest%.Diff_cumuldollaramt);
    Count_Diff_contfiller1 := COUNT(GROUP,%Closest%.Diff_contfiller1);
    Count_Diff_contfiller2 := COUNT(GROUP,%Closest%.Diff_contfiller2);
    Count_Diff_conttype := COUNT(GROUP,%Closest%.Diff_conttype);
    Count_Diff_contfiller3 := COUNT(GROUP,%Closest%.Diff_contfiller3);
    Count_Diff_primary02 := COUNT(GROUP,%Closest%.Diff_primary02);
    Count_Diff_special02 := COUNT(GROUP,%Closest%.Diff_special02);
    Count_Diff_other02 := COUNT(GROUP,%Closest%.Diff_other02);
    Count_Diff_special202 := COUNT(GROUP,%Closest%.Diff_special202);
    Count_Diff_general02 := COUNT(GROUP,%Closest%.Diff_general02);
    Count_Diff_primary01 := COUNT(GROUP,%Closest%.Diff_primary01);
    Count_Diff_special01 := COUNT(GROUP,%Closest%.Diff_special01);
    Count_Diff_other01 := COUNT(GROUP,%Closest%.Diff_other01);
    Count_Diff_special201 := COUNT(GROUP,%Closest%.Diff_special201);
    Count_Diff_general01 := COUNT(GROUP,%Closest%.Diff_general01);
    Count_Diff_pres00 := COUNT(GROUP,%Closest%.Diff_pres00);
    Count_Diff_primary00 := COUNT(GROUP,%Closest%.Diff_primary00);
    Count_Diff_special00 := COUNT(GROUP,%Closest%.Diff_special00);
    Count_Diff_other00 := COUNT(GROUP,%Closest%.Diff_other00);
    Count_Diff_special200 := COUNT(GROUP,%Closest%.Diff_special200);
    Count_Diff_general00 := COUNT(GROUP,%Closest%.Diff_general00);
    Count_Diff_primary99 := COUNT(GROUP,%Closest%.Diff_primary99);
    Count_Diff_special99 := COUNT(GROUP,%Closest%.Diff_special99);
    Count_Diff_other99 := COUNT(GROUP,%Closest%.Diff_other99);
    Count_Diff_special299 := COUNT(GROUP,%Closest%.Diff_special299);
    Count_Diff_general99 := COUNT(GROUP,%Closest%.Diff_general99);
    Count_Diff_primary98 := COUNT(GROUP,%Closest%.Diff_primary98);
    Count_Diff_special98 := COUNT(GROUP,%Closest%.Diff_special98);
    Count_Diff_other98 := COUNT(GROUP,%Closest%.Diff_other98);
    Count_Diff_special298 := COUNT(GROUP,%Closest%.Diff_special298);
    Count_Diff_general98 := COUNT(GROUP,%Closest%.Diff_general98);
    Count_Diff_primary97 := COUNT(GROUP,%Closest%.Diff_primary97);
    Count_Diff_special97 := COUNT(GROUP,%Closest%.Diff_special97);
    Count_Diff_other97 := COUNT(GROUP,%Closest%.Diff_other97);
    Count_Diff_special297 := COUNT(GROUP,%Closest%.Diff_special297);
    Count_Diff_general97 := COUNT(GROUP,%Closest%.Diff_general97);
    Count_Diff_pres96 := COUNT(GROUP,%Closest%.Diff_pres96);
    Count_Diff_primary96 := COUNT(GROUP,%Closest%.Diff_primary96);
    Count_Diff_special96 := COUNT(GROUP,%Closest%.Diff_special96);
    Count_Diff_other96 := COUNT(GROUP,%Closest%.Diff_other96);
    Count_Diff_special296 := COUNT(GROUP,%Closest%.Diff_special296);
    Count_Diff_general96 := COUNT(GROUP,%Closest%.Diff_general96);
    Count_Diff_lastdayvote := COUNT(GROUP,%Closest%.Diff_lastdayvote);
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
