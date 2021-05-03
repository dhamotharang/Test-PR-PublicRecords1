IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT HVCCW_Fields := MODULE
 
EXPORT NumFields := 428;
 
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
  s1 := SALT311.stringfilter(s0,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .,\'-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .,\'-'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .,\'-'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_seqnum','persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob_str_in','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate_in','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr_in','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote_in','historyfiller','huntfishperm','datelicense_in','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','boatindexnum','boatcoowner','hullidnum','yearmade','model','manufacturer','lengt','hullconstruct','primuse','fueltype','propulsion','modeltype','regexpdate_in','titlenum','stprimuse','titlestatus','vessel','specreg','boatfill1','boatfill2','boatfill3','ccwpermnum','ccwweapontype','ccwregdate_in','ccwexpdate_in','ccwpermtype','ccwfill1','ccwfill2','ccwfill3','ccwfill4','miscfill1','miscfill2','miscfill3','miscfill4','miscfill5','fillerother1','fillerother2','fillerother3','fillerother4','fillerother5','fillerother6','fillerother7','fillerother8','fillerother9','fillerother10','eor','stuff','dob_str','regdate','dateofcontr','lastdayvote','datelicense','regexpdate','ccwregdate','ccwexpdate','title','fname','mname','lname','name_suffix','score_on_input','append_prep_resaddress1','append_prep_resaddress2','append_resrawaid','append_prep_mailaddress1','append_prep_mailaddress2','append_mailrawaid','append_prep_cassaddress1','append_prep_cassaddress2','append_cassrawaid','aid_resclean_prim_range','aid_resclean_predir','aid_resclean_prim_name','aid_resclean_addr_suffix','aid_resclean_postdir','aid_resclean_unit_desig','aid_resclean_sec_range','aid_resclean_p_city_name','aid_resclean_v_city_name','aid_resclean_st','aid_resclean_zip','aid_resclean_zip4','aid_resclean_cart','aid_resclean_cr_sort_sz','aid_resclean_lot','aid_resclean_lot_order','aid_resclean_dpbc','aid_resclean_chk_digit','aid_resclean_record_type','aid_resclean_ace_fips_st','aid_resclean_fipscounty','aid_resclean_geo_lat','aid_resclean_geo_long','aid_resclean_msa','aid_resclean_geo_blk','aid_resclean_geo_match','aid_resclean_err_stat','aid_mailclean_prim_range','aid_mailclean_predir','aid_mailclean_prim_name','aid_mailclean_addr_suffix','aid_mailclean_postdir','aid_mailclean_unit_desig','aid_mailclean_sec_range','aid_mailclean_p_city_name','aid_mailclean_v_city_name','aid_mailclean_st','aid_mailclean_zip','aid_mailclean_zip4','aid_mailclean_cart','aid_mailclean_cr_sort_sz','aid_mailclean_lot','aid_mailclean_lot_order','aid_mailclean_dpbc','aid_mailclean_chk_digit','aid_mailclean_record_type','aid_mailclean_ace_fips_st','aid_mailclean_fipscounty','aid_mailclean_geo_lat','aid_mailclean_geo_long','aid_mailclean_msa','aid_mailclean_geo_blk','aid_mailclean_geo_match','aid_mailclean_err_stat','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','cass_prim_range','cass_predir','cass_prim_name','cass_addr_suffix','cass_postdir','cass_unit_desig','cass_sec_range','cass_p_city_name','cass_v_city_name','cass_st','cass_ace_zip','cass_zip4','cass_cart','cass_cr_sort_sz','cass_lot','cass_lot_order','cass_dpbc','cass_chk_digit','cass_record_type','cass_ace_fips_st','cass_fipscounty','cass_geo_lat','cass_geo_long','cass_msa','cass_geo_blk','cass_geo_match','cass_err_stat');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'append_seqnum','persistent_record_id','process_date','date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob_str_in','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate_in','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','county_filler','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','contributorparty','recptparty','dateofcontr_in','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller3','primary02','special02','other02','special202','general02','primary01','special01','other01','special201','general01','pres00','primary00','special00','other00','special200','general00','primary99','special99','other99','special299','general99','primary98','special98','other98','special298','general98','primary97','special97','other97','special297','general97','pres96','primary96','special96','other96','special296','general96','lastdayvote_in','historyfiller','huntfishperm','datelicense_in','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','boatindexnum','boatcoowner','hullidnum','yearmade','model','manufacturer','lengt','hullconstruct','primuse','fueltype','propulsion','modeltype','regexpdate_in','titlenum','stprimuse','titlestatus','vessel','specreg','boatfill1','boatfill2','boatfill3','ccwpermnum','ccwweapontype','ccwregdate_in','ccwexpdate_in','ccwpermtype','ccwfill1','ccwfill2','ccwfill3','ccwfill4','miscfill1','miscfill2','miscfill3','miscfill4','miscfill5','fillerother1','fillerother2','fillerother3','fillerother4','fillerother5','fillerother6','fillerother7','fillerother8','fillerother9','fillerother10','eor','stuff','dob_str','regdate','dateofcontr','lastdayvote','datelicense','regexpdate','ccwregdate','ccwexpdate','title','fname','mname','lname','name_suffix','score_on_input','append_prep_resaddress1','append_prep_resaddress2','append_resrawaid','append_prep_mailaddress1','append_prep_mailaddress2','append_mailrawaid','append_prep_cassaddress1','append_prep_cassaddress2','append_cassrawaid','aid_resclean_prim_range','aid_resclean_predir','aid_resclean_prim_name','aid_resclean_addr_suffix','aid_resclean_postdir','aid_resclean_unit_desig','aid_resclean_sec_range','aid_resclean_p_city_name','aid_resclean_v_city_name','aid_resclean_st','aid_resclean_zip','aid_resclean_zip4','aid_resclean_cart','aid_resclean_cr_sort_sz','aid_resclean_lot','aid_resclean_lot_order','aid_resclean_dpbc','aid_resclean_chk_digit','aid_resclean_record_type','aid_resclean_ace_fips_st','aid_resclean_fipscounty','aid_resclean_geo_lat','aid_resclean_geo_long','aid_resclean_msa','aid_resclean_geo_blk','aid_resclean_geo_match','aid_resclean_err_stat','aid_mailclean_prim_range','aid_mailclean_predir','aid_mailclean_prim_name','aid_mailclean_addr_suffix','aid_mailclean_postdir','aid_mailclean_unit_desig','aid_mailclean_sec_range','aid_mailclean_p_city_name','aid_mailclean_v_city_name','aid_mailclean_st','aid_mailclean_zip','aid_mailclean_zip4','aid_mailclean_cart','aid_mailclean_cr_sort_sz','aid_mailclean_lot','aid_mailclean_lot_order','aid_mailclean_dpbc','aid_mailclean_chk_digit','aid_mailclean_record_type','aid_mailclean_ace_fips_st','aid_mailclean_fipscounty','aid_mailclean_geo_lat','aid_mailclean_geo_long','aid_mailclean_msa','aid_mailclean_geo_blk','aid_mailclean_geo_match','aid_mailclean_err_stat','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','cass_prim_range','cass_predir','cass_prim_name','cass_addr_suffix','cass_postdir','cass_unit_desig','cass_sec_range','cass_p_city_name','cass_v_city_name','cass_st','cass_ace_zip','cass_zip4','cass_cart','cass_cr_sort_sz','cass_lot','cass_lot_order','cass_dpbc','cass_chk_digit','cass_record_type','cass_ace_fips_st','cass_fipscounty','cass_geo_lat','cass_geo_long','cass_msa','cass_geo_blk','cass_geo_match','cass_err_stat');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'append_seqnum' => 0,'persistent_record_id' => 1,'process_date' => 2,'date_first_seen' => 3,'date_last_seen' => 4,'score' => 5,'best_ssn' => 6,'did_out' => 7,'source' => 8,'file_id' => 9,'vendor_id' => 10,'source_state' => 11,'source_code' => 12,'file_acquired_date' => 13,'_use' => 14,'title_in' => 15,'lname_in' => 16,'fname_in' => 17,'mname_in' => 18,'maiden_prior' => 19,'name_suffix_in' => 20,'votefiller' => 21,'source_voterid' => 22,'dob_str_in' => 23,'agecat' => 24,'headhousehold' => 25,'place_of_birth' => 26,'occupation' => 27,'maiden_name' => 28,'motorvoterid' => 29,'regsource' => 30,'regdate_in' => 31,'race' => 32,'gender' => 33,'poliparty' => 34,'phone' => 35,'work_phone' => 36,'other_phone' => 37,'active_status' => 38,'votefiller2' => 39,'active_other' => 40,'voterstatus' => 41,'resaddr1' => 42,'resaddr2' => 43,'res_city' => 44,'res_state' => 45,'res_zip' => 46,'res_county' => 47,'mail_addr1' => 48,'mail_addr2' => 49,'mail_city' => 50,'mail_state' => 51,'mail_zip' => 52,'mail_county' => 53,'addr_filler1' => 54,'addr_filler2' => 55,'city_filler' => 56,'state_filler' => 57,'zip_filler' => 58,'county_filler' => 59,'towncode' => 60,'distcode' => 61,'countycode' => 62,'schoolcode' => 63,'cityinout' => 64,'spec_dist1' => 65,'spec_dist2' => 66,'precinct1' => 67,'precinct2' => 68,'precinct3' => 69,'villageprecinct' => 70,'schoolprecinct' => 71,'ward' => 72,'precinct_citytown' => 73,'ancsmdindc' => 74,'citycouncildist' => 75,'countycommdist' => 76,'statehouse' => 77,'statesenate' => 78,'ushouse' => 79,'elemschooldist' => 80,'schooldist' => 81,'schoolfiller' => 82,'commcolldist' => 83,'dist_filler' => 84,'municipal' => 85,'villagedist' => 86,'policejury' => 87,'policedist' => 88,'publicservcomm' => 89,'rescue' => 90,'fire' => 91,'sanitary' => 92,'sewerdist' => 93,'waterdist' => 94,'mosquitodist' => 95,'taxdist' => 96,'supremecourt' => 97,'justiceofpeace' => 98,'judicialdist' => 99,'superiorctdist' => 100,'appealsct' => 101,'courtfiller' => 102,'contributorparty' => 103,'recptparty' => 104,'dateofcontr_in' => 105,'dollaramt' => 106,'officecontto' => 107,'cumuldollaramt' => 108,'contfiller1' => 109,'contfiller2' => 110,'conttype' => 111,'contfiller3' => 112,'primary02' => 113,'special02' => 114,'other02' => 115,'special202' => 116,'general02' => 117,'primary01' => 118,'special01' => 119,'other01' => 120,'special201' => 121,'general01' => 122,'pres00' => 123,'primary00' => 124,'special00' => 125,'other00' => 126,'special200' => 127,'general00' => 128,'primary99' => 129,'special99' => 130,'other99' => 131,'special299' => 132,'general99' => 133,'primary98' => 134,'special98' => 135,'other98' => 136,'special298' => 137,'general98' => 138,'primary97' => 139,'special97' => 140,'other97' => 141,'special297' => 142,'general97' => 143,'pres96' => 144,'primary96' => 145,'special96' => 146,'other96' => 147,'special296' => 148,'general96' => 149,'lastdayvote_in' => 150,'historyfiller' => 151,'huntfishperm' => 152,'datelicense_in' => 153,'homestate' => 154,'resident' => 155,'nonresident' => 156,'hunt' => 157,'fish' => 158,'combosuper' => 159,'sportsman' => 160,'trap' => 161,'archery' => 162,'muzzle' => 163,'drawing' => 164,'day1' => 165,'day3' => 166,'day7' => 167,'day14to15' => 168,'dayfiller' => 169,'seasonannual' => 170,'lifetimepermit' => 171,'landowner' => 172,'family' => 173,'junior' => 174,'seniorcit' => 175,'crewmemeber' => 176,'retarded' => 177,'indian' => 178,'serviceman' => 179,'disabled' => 180,'lowincome' => 181,'regioncounty' => 182,'blind' => 183,'huntfiller' => 184,'salmon' => 185,'freshwater' => 186,'saltwater' => 187,'lakesandresevoirs' => 188,'setlinefish' => 189,'trout' => 190,'fallfishing' => 191,'steelhead' => 192,'whitejubherring' => 193,'sturgeon' => 194,'shellfishcrab' => 195,'shellfishlobster' => 196,'deer' => 197,'bear' => 198,'elk' => 199,'moose' => 200,'buffalo' => 201,'antelope' => 202,'sikebull' => 203,'bighorn' => 204,'javelina' => 205,'cougar' => 206,'anterless' => 207,'pheasant' => 208,'goose' => 209,'duck' => 210,'turkey' => 211,'snowmobile' => 212,'biggame' => 213,'skipass' => 214,'migbird' => 215,'smallgame' => 216,'sturgeon2' => 217,'gun' => 218,'bonus' => 219,'lottery' => 220,'otherbirds' => 221,'huntfill1' => 222,'boatindexnum' => 223,'boatcoowner' => 224,'hullidnum' => 225,'yearmade' => 226,'model' => 227,'manufacturer' => 228,'lengt' => 229,'hullconstruct' => 230,'primuse' => 231,'fueltype' => 232,'propulsion' => 233,'modeltype' => 234,'regexpdate_in' => 235,'titlenum' => 236,'stprimuse' => 237,'titlestatus' => 238,'vessel' => 239,'specreg' => 240,'boatfill1' => 241,'boatfill2' => 242,'boatfill3' => 243,'ccwpermnum' => 244,'ccwweapontype' => 245,'ccwregdate_in' => 246,'ccwexpdate_in' => 247,'ccwpermtype' => 248,'ccwfill1' => 249,'ccwfill2' => 250,'ccwfill3' => 251,'ccwfill4' => 252,'miscfill1' => 253,'miscfill2' => 254,'miscfill3' => 255,'miscfill4' => 256,'miscfill5' => 257,'fillerother1' => 258,'fillerother2' => 259,'fillerother3' => 260,'fillerother4' => 261,'fillerother5' => 262,'fillerother6' => 263,'fillerother7' => 264,'fillerother8' => 265,'fillerother9' => 266,'fillerother10' => 267,'eor' => 268,'stuff' => 269,'dob_str' => 270,'regdate' => 271,'dateofcontr' => 272,'lastdayvote' => 273,'datelicense' => 274,'regexpdate' => 275,'ccwregdate' => 276,'ccwexpdate' => 277,'title' => 278,'fname' => 279,'mname' => 280,'lname' => 281,'name_suffix' => 282,'score_on_input' => 283,'append_prep_resaddress1' => 284,'append_prep_resaddress2' => 285,'append_resrawaid' => 286,'append_prep_mailaddress1' => 287,'append_prep_mailaddress2' => 288,'append_mailrawaid' => 289,'append_prep_cassaddress1' => 290,'append_prep_cassaddress2' => 291,'append_cassrawaid' => 292,'aid_resclean_prim_range' => 293,'aid_resclean_predir' => 294,'aid_resclean_prim_name' => 295,'aid_resclean_addr_suffix' => 296,'aid_resclean_postdir' => 297,'aid_resclean_unit_desig' => 298,'aid_resclean_sec_range' => 299,'aid_resclean_p_city_name' => 300,'aid_resclean_v_city_name' => 301,'aid_resclean_st' => 302,'aid_resclean_zip' => 303,'aid_resclean_zip4' => 304,'aid_resclean_cart' => 305,'aid_resclean_cr_sort_sz' => 306,'aid_resclean_lot' => 307,'aid_resclean_lot_order' => 308,'aid_resclean_dpbc' => 309,'aid_resclean_chk_digit' => 310,'aid_resclean_record_type' => 311,'aid_resclean_ace_fips_st' => 312,'aid_resclean_fipscounty' => 313,'aid_resclean_geo_lat' => 314,'aid_resclean_geo_long' => 315,'aid_resclean_msa' => 316,'aid_resclean_geo_blk' => 317,'aid_resclean_geo_match' => 318,'aid_resclean_err_stat' => 319,'aid_mailclean_prim_range' => 320,'aid_mailclean_predir' => 321,'aid_mailclean_prim_name' => 322,'aid_mailclean_addr_suffix' => 323,'aid_mailclean_postdir' => 324,'aid_mailclean_unit_desig' => 325,'aid_mailclean_sec_range' => 326,'aid_mailclean_p_city_name' => 327,'aid_mailclean_v_city_name' => 328,'aid_mailclean_st' => 329,'aid_mailclean_zip' => 330,'aid_mailclean_zip4' => 331,'aid_mailclean_cart' => 332,'aid_mailclean_cr_sort_sz' => 333,'aid_mailclean_lot' => 334,'aid_mailclean_lot_order' => 335,'aid_mailclean_dpbc' => 336,'aid_mailclean_chk_digit' => 337,'aid_mailclean_record_type' => 338,'aid_mailclean_ace_fips_st' => 339,'aid_mailclean_fipscounty' => 340,'aid_mailclean_geo_lat' => 341,'aid_mailclean_geo_long' => 342,'aid_mailclean_msa' => 343,'aid_mailclean_geo_blk' => 344,'aid_mailclean_geo_match' => 345,'aid_mailclean_err_stat' => 346,'prim_range' => 347,'predir' => 348,'prim_name' => 349,'suffix' => 350,'postdir' => 351,'unit_desig' => 352,'sec_range' => 353,'p_city_name' => 354,'city_name' => 355,'st' => 356,'zip' => 357,'zip4' => 358,'cart' => 359,'cr_sort_sz' => 360,'lot' => 361,'lot_order' => 362,'dpbc' => 363,'chk_digit' => 364,'record_type' => 365,'ace_fips_st' => 366,'county' => 367,'geo_lat' => 368,'geo_long' => 369,'msa' => 370,'geo_blk' => 371,'geo_match' => 372,'err_stat' => 373,'mail_prim_range' => 374,'mail_predir' => 375,'mail_prim_name' => 376,'mail_addr_suffix' => 377,'mail_postdir' => 378,'mail_unit_desig' => 379,'mail_sec_range' => 380,'mail_p_city_name' => 381,'mail_v_city_name' => 382,'mail_st' => 383,'mail_ace_zip' => 384,'mail_zip4' => 385,'mail_cart' => 386,'mail_cr_sort_sz' => 387,'mail_lot' => 388,'mail_lot_order' => 389,'mail_dpbc' => 390,'mail_chk_digit' => 391,'mail_record_type' => 392,'mail_ace_fips_st' => 393,'mail_fipscounty' => 394,'mail_geo_lat' => 395,'mail_geo_long' => 396,'mail_msa' => 397,'mail_geo_blk' => 398,'mail_geo_match' => 399,'mail_err_stat' => 400,'cass_prim_range' => 401,'cass_predir' => 402,'cass_prim_name' => 403,'cass_addr_suffix' => 404,'cass_postdir' => 405,'cass_unit_desig' => 406,'cass_sec_range' => 407,'cass_p_city_name' => 408,'cass_v_city_name' => 409,'cass_st' => 410,'cass_ace_zip' => 411,'cass_zip4' => 412,'cass_cart' => 413,'cass_cr_sort_sz' => 414,'cass_lot' => 415,'cass_lot_order' => 416,'cass_dpbc' => 417,'cass_chk_digit' => 418,'cass_record_type' => 419,'cass_ace_fips_st' => 420,'cass_fipscounty' => 421,'cass_geo_lat' => 422,'cass_geo_long' => 423,'cass_msa' => 424,'cass_geo_blk' => 425,'cass_geo_match' => 426,'cass_err_stat' => 427,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_append_seqnum(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_append_seqnum(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_append_seqnum(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
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
 
EXPORT Make_best_ssn(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_best_ssn(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_did_out(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did_out(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did_out(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_file_id(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_file_id(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_vendor_id(SALT311.StrType s0) := s0;
EXPORT InValid_vendor_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := '';
 
EXPORT Make_source_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_source_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_source_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
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
 
EXPORT Make_source_voterid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_source_voterid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_source_voterid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_dob_str_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dob_str_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dob_str_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
 
EXPORT Make_regdate_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_regdate_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_regdate_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_race(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_race(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_poliparty(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_poliparty(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_poliparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_work_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_work_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_other_phone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_other_phone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_other_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_active_status(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_active_status(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_active_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_votefiller2(SALT311.StrType s0) := s0;
EXPORT InValid_votefiller2(SALT311.StrType s) := 0;
EXPORT InValidMessage_votefiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_active_other(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_active_other(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_active_other(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_voterstatus(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_voterstatus(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_voterstatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_resaddr1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_resaddr1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_resaddr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_resaddr2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_resaddr2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_resaddr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_res_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_res_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_res_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_res_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_res_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_res_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_res_zip(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_res_zip(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_res_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
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
 
EXPORT Make_mail_zip(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_mail_zip(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_mail_county(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_county(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_cityinout(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cityinout(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cityinout(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
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
 
EXPORT Make_statehouse(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_statehouse(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_statehouse(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_statesenate(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_statesenate(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_statesenate(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
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
 
EXPORT Make_municipal(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_municipal(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_municipal(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_villagedist(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_villagedist(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_villagedist(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policejury(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policejury(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policejury(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policedist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_policedist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_policedist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_publicservcomm(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_publicservcomm(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_publicservcomm(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rescue(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rescue(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rescue(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_fire(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_fire(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_fire(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sanitary(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_sanitary(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_sanitary(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_sewerdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_sewerdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_sewerdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_waterdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_waterdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_waterdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mosquitodist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mosquitodist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mosquitodist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_taxdist(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_taxdist(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_taxdist(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_appealsct(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_appealsct(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_appealsct(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_courtfiller(SALT311.StrType s0) := s0;
EXPORT InValid_courtfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_contributorparty(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contributorparty(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contributorparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_recptparty(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_recptparty(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_recptparty(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_dateofcontr_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateofcontr_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateofcontr_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dollaramt(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dollaramt(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dollaramt(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_officecontto(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_officecontto(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_officecontto(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cumuldollaramt(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cumuldollaramt(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cumuldollaramt(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_contfiller1(SALT311.StrType s0) := s0;
EXPORT InValid_contfiller1(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfiller1(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller2(SALT311.StrType s0) := s0;
EXPORT InValid_contfiller2(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_conttype(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_conttype(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_conttype(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
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
 
EXPORT Make_lastdayvote_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_lastdayvote_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_lastdayvote_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_historyfiller(SALT311.StrType s0) := s0;
EXPORT InValid_historyfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_historyfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_huntfishperm(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_huntfishperm(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_huntfishperm(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_datelicense_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_datelicense_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_datelicense_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
 
EXPORT Make_day1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_day1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_day1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_day3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_day3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_day3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_day7(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_day7(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_day7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_day14to15(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_day14to15(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_day14to15(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dayfiller(SALT311.StrType s0) := s0;
EXPORT InValid_dayfiller(SALT311.StrType s) := 0;
EXPORT InValidMessage_dayfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_seasonannual(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_seasonannual(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_seasonannual(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
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
 
EXPORT Make_regioncounty(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_regioncounty(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_regioncounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_boatindexnum(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_boatindexnum(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_boatindexnum(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_boatcoowner(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_boatcoowner(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_boatcoowner(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_hullidnum(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_hullidnum(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_hullidnum(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_yearmade(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_yearmade(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_yearmade(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_model(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_model(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_manufacturer(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_manufacturer(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_manufacturer(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lengt(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_lengt(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_lengt(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_hullconstruct(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_hullconstruct(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_hullconstruct(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_primuse(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primuse(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primuse(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_fueltype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_fueltype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_fueltype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_propulsion(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_propulsion(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_propulsion(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_modeltype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_modeltype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_modeltype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_regexpdate_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_regexpdate_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_regexpdate_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_titlenum(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_titlenum(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_titlenum(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_stprimuse(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_stprimuse(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_stprimuse(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_titlestatus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_titlestatus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_titlestatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_vessel(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_vessel(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_vessel(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_specreg(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_specreg(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_specreg(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_boatfill1(SALT311.StrType s0) := s0;
EXPORT InValid_boatfill1(SALT311.StrType s) := 0;
EXPORT InValidMessage_boatfill1(UNSIGNED1 wh) := '';
 
EXPORT Make_boatfill2(SALT311.StrType s0) := s0;
EXPORT InValid_boatfill2(SALT311.StrType s) := 0;
EXPORT InValidMessage_boatfill2(UNSIGNED1 wh) := '';
 
EXPORT Make_boatfill3(SALT311.StrType s0) := s0;
EXPORT InValid_boatfill3(SALT311.StrType s) := 0;
EXPORT InValidMessage_boatfill3(UNSIGNED1 wh) := '';
 
EXPORT Make_ccwpermnum(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ccwpermnum(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ccwpermnum(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ccwweapontype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_ccwweapontype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_ccwweapontype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_ccwregdate_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_ccwregdate_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_ccwregdate_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ccwexpdate_in(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_ccwexpdate_in(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_ccwexpdate_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ccwpermtype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_ccwpermtype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_ccwpermtype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_ccwfill1(SALT311.StrType s0) := s0;
EXPORT InValid_ccwfill1(SALT311.StrType s) := 0;
EXPORT InValidMessage_ccwfill1(UNSIGNED1 wh) := '';
 
EXPORT Make_ccwfill2(SALT311.StrType s0) := s0;
EXPORT InValid_ccwfill2(SALT311.StrType s) := 0;
EXPORT InValidMessage_ccwfill2(UNSIGNED1 wh) := '';
 
EXPORT Make_ccwfill3(SALT311.StrType s0) := s0;
EXPORT InValid_ccwfill3(SALT311.StrType s) := 0;
EXPORT InValidMessage_ccwfill3(UNSIGNED1 wh) := '';
 
EXPORT Make_ccwfill4(SALT311.StrType s0) := s0;
EXPORT InValid_ccwfill4(SALT311.StrType s) := 0;
EXPORT InValidMessage_ccwfill4(UNSIGNED1 wh) := '';
 
EXPORT Make_miscfill1(SALT311.StrType s0) := s0;
EXPORT InValid_miscfill1(SALT311.StrType s) := 0;
EXPORT InValidMessage_miscfill1(UNSIGNED1 wh) := '';
 
EXPORT Make_miscfill2(SALT311.StrType s0) := s0;
EXPORT InValid_miscfill2(SALT311.StrType s) := 0;
EXPORT InValidMessage_miscfill2(UNSIGNED1 wh) := '';
 
EXPORT Make_miscfill3(SALT311.StrType s0) := s0;
EXPORT InValid_miscfill3(SALT311.StrType s) := 0;
EXPORT InValidMessage_miscfill3(UNSIGNED1 wh) := '';
 
EXPORT Make_miscfill4(SALT311.StrType s0) := s0;
EXPORT InValid_miscfill4(SALT311.StrType s) := 0;
EXPORT InValidMessage_miscfill4(UNSIGNED1 wh) := '';
 
EXPORT Make_miscfill5(SALT311.StrType s0) := s0;
EXPORT InValid_miscfill5(SALT311.StrType s) := 0;
EXPORT InValidMessage_miscfill5(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother1(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother1(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother1(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother2(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother2(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother2(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother3(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother3(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother3(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother4(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother4(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother4(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother5(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother5(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother5(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother6(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother6(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother6(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother7(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother7(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother7(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother8(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother8(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother8(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother9(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother9(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother9(UNSIGNED1 wh) := '';
 
EXPORT Make_fillerother10(SALT311.StrType s0) := s0;
EXPORT InValid_fillerother10(SALT311.StrType s) := 0;
EXPORT InValidMessage_fillerother10(UNSIGNED1 wh) := '';
 
EXPORT Make_eor(SALT311.StrType s0) := s0;
EXPORT InValid_eor(SALT311.StrType s) := 0;
EXPORT InValidMessage_eor(UNSIGNED1 wh) := '';
 
EXPORT Make_stuff(SALT311.StrType s0) := s0;
EXPORT InValid_stuff(SALT311.StrType s) := 0;
EXPORT InValidMessage_stuff(UNSIGNED1 wh) := '';
 
EXPORT Make_dob_str(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dob_str(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dob_str(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_regdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_regdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_regdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dateofcontr(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateofcontr(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateofcontr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_lastdayvote(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_lastdayvote(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_lastdayvote(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_datelicense(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_datelicense(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_datelicense(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_regexpdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_regexpdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_regexpdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ccwregdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_ccwregdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_ccwregdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_ccwexpdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_ccwexpdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_ccwexpdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
 
EXPORT Make_append_prep_resaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_resaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_resaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_prep_resaddress2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_resaddress2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_resaddress2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_resrawaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_append_resrawaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_append_resrawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_append_prep_mailaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_mailaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_mailaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_prep_mailaddress2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_mailaddress2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_mailaddress2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_mailrawaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_append_mailrawaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_append_mailrawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_append_prep_cassaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_cassaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_cassaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_prep_cassaddress2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_prep_cassaddress2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_prep_cassaddress2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_cassrawaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_append_cassrawaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_append_cassrawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_prim_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_prim_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_resclean_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_resclean_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_resclean_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_aid_resclean_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_aid_resclean_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_aid_resclean_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_aid_resclean_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_aid_resclean_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_aid_resclean_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_resclean_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_dpbc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_dpbc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_resclean_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_resclean_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_resclean_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_resclean_fipscounty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_fipscounty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_fipscounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_resclean_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_resclean_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_resclean_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_resclean_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_resclean_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_resclean_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_resclean_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_resclean_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_resclean_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_resclean_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_resclean_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_resclean_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_resclean_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_resclean_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_mailclean_prim_range(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_prim_range(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_mailclean_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_mailclean_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_mailclean_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_sec_range(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_aid_mailclean_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_aid_mailclean_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_aid_mailclean_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_aid_mailclean_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_aid_mailclean_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_aid_mailclean_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_mailclean_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_mailclean_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_mailclean_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_mailclean_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_mailclean_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_mailclean_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_mailclean_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_mailclean_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_mailclean_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_dpbc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_mailclean_dpbc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_mailclean_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_mailclean_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_mailclean_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_mailclean_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_mailclean_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_aid_mailclean_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_aid_mailclean_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aid_mailclean_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_mailclean_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_mailclean_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_aid_mailclean_fipscounty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aid_mailclean_fipscounty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aid_mailclean_fipscounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aid_mailclean_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_mailclean_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_mailclean_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_mailclean_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_mailclean_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_mailclean_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_mailclean_msa(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_mailclean_msa(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_mailclean_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_mailclean_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_mailclean_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_mailclean_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_mailclean_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_aid_mailclean_geo_match(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_aid_mailclean_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_aid_mailclean_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_aid_mailclean_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_aid_mailclean_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_mail_prim_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_prim_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_mail_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_sec_range(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mail_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mail_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mail_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_mail_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_mail_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
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
 
EXPORT Make_mail_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mail_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mail_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
 
EXPORT Make_mail_err_stat(SALT311.StrType s0) := s0;
EXPORT InValid_mail_err_stat(SALT311.StrType s) := 0;
EXPORT InValidMessage_mail_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_cass_prim_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cass_prim_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cass_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cass_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_prim_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_sec_range(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_cass_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_cass_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_cass_ace_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_cass_ace_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_cass_ace_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_cass_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cass_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cass_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cass_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cass_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cass_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cass_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cass_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cass_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cass_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_dpbc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cass_dpbc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cass_dpbc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cass_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cass_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cass_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cass_record_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_cass_record_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_cass_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cass_ace_fips_st(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cass_ace_fips_st(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cass_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cass_fipscounty(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cass_fipscounty(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cass_fipscounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cass_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cass_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cass_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cass_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cass_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cass_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cass_msa(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cass_msa(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cass_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cass_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cass_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cass_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cass_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_cass_geo_match(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_cass_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_cass_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_cass_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_cass_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
    BOOLEAN Diff_append_seqnum;
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
    BOOLEAN Diff_dob_str_in;
    BOOLEAN Diff_agecat;
    BOOLEAN Diff_headhousehold;
    BOOLEAN Diff_place_of_birth;
    BOOLEAN Diff_occupation;
    BOOLEAN Diff_maiden_name;
    BOOLEAN Diff_motorvoterid;
    BOOLEAN Diff_regsource;
    BOOLEAN Diff_regdate_in;
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
    BOOLEAN Diff_dateofcontr_in;
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
    BOOLEAN Diff_lastdayvote_in;
    BOOLEAN Diff_historyfiller;
    BOOLEAN Diff_huntfishperm;
    BOOLEAN Diff_datelicense_in;
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
    BOOLEAN Diff_boatindexnum;
    BOOLEAN Diff_boatcoowner;
    BOOLEAN Diff_hullidnum;
    BOOLEAN Diff_yearmade;
    BOOLEAN Diff_model;
    BOOLEAN Diff_manufacturer;
    BOOLEAN Diff_lengt;
    BOOLEAN Diff_hullconstruct;
    BOOLEAN Diff_primuse;
    BOOLEAN Diff_fueltype;
    BOOLEAN Diff_propulsion;
    BOOLEAN Diff_modeltype;
    BOOLEAN Diff_regexpdate_in;
    BOOLEAN Diff_titlenum;
    BOOLEAN Diff_stprimuse;
    BOOLEAN Diff_titlestatus;
    BOOLEAN Diff_vessel;
    BOOLEAN Diff_specreg;
    BOOLEAN Diff_boatfill1;
    BOOLEAN Diff_boatfill2;
    BOOLEAN Diff_boatfill3;
    BOOLEAN Diff_ccwpermnum;
    BOOLEAN Diff_ccwweapontype;
    BOOLEAN Diff_ccwregdate_in;
    BOOLEAN Diff_ccwexpdate_in;
    BOOLEAN Diff_ccwpermtype;
    BOOLEAN Diff_ccwfill1;
    BOOLEAN Diff_ccwfill2;
    BOOLEAN Diff_ccwfill3;
    BOOLEAN Diff_ccwfill4;
    BOOLEAN Diff_miscfill1;
    BOOLEAN Diff_miscfill2;
    BOOLEAN Diff_miscfill3;
    BOOLEAN Diff_miscfill4;
    BOOLEAN Diff_miscfill5;
    BOOLEAN Diff_fillerother1;
    BOOLEAN Diff_fillerother2;
    BOOLEAN Diff_fillerother3;
    BOOLEAN Diff_fillerother4;
    BOOLEAN Diff_fillerother5;
    BOOLEAN Diff_fillerother6;
    BOOLEAN Diff_fillerother7;
    BOOLEAN Diff_fillerother8;
    BOOLEAN Diff_fillerother9;
    BOOLEAN Diff_fillerother10;
    BOOLEAN Diff_eor;
    BOOLEAN Diff_stuff;
    BOOLEAN Diff_dob_str;
    BOOLEAN Diff_regdate;
    BOOLEAN Diff_dateofcontr;
    BOOLEAN Diff_lastdayvote;
    BOOLEAN Diff_datelicense;
    BOOLEAN Diff_regexpdate;
    BOOLEAN Diff_ccwregdate;
    BOOLEAN Diff_ccwexpdate;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_score_on_input;
    BOOLEAN Diff_append_prep_resaddress1;
    BOOLEAN Diff_append_prep_resaddress2;
    BOOLEAN Diff_append_resrawaid;
    BOOLEAN Diff_append_prep_mailaddress1;
    BOOLEAN Diff_append_prep_mailaddress2;
    BOOLEAN Diff_append_mailrawaid;
    BOOLEAN Diff_append_prep_cassaddress1;
    BOOLEAN Diff_append_prep_cassaddress2;
    BOOLEAN Diff_append_cassrawaid;
    BOOLEAN Diff_aid_resclean_prim_range;
    BOOLEAN Diff_aid_resclean_predir;
    BOOLEAN Diff_aid_resclean_prim_name;
    BOOLEAN Diff_aid_resclean_addr_suffix;
    BOOLEAN Diff_aid_resclean_postdir;
    BOOLEAN Diff_aid_resclean_unit_desig;
    BOOLEAN Diff_aid_resclean_sec_range;
    BOOLEAN Diff_aid_resclean_p_city_name;
    BOOLEAN Diff_aid_resclean_v_city_name;
    BOOLEAN Diff_aid_resclean_st;
    BOOLEAN Diff_aid_resclean_zip;
    BOOLEAN Diff_aid_resclean_zip4;
    BOOLEAN Diff_aid_resclean_cart;
    BOOLEAN Diff_aid_resclean_cr_sort_sz;
    BOOLEAN Diff_aid_resclean_lot;
    BOOLEAN Diff_aid_resclean_lot_order;
    BOOLEAN Diff_aid_resclean_dpbc;
    BOOLEAN Diff_aid_resclean_chk_digit;
    BOOLEAN Diff_aid_resclean_record_type;
    BOOLEAN Diff_aid_resclean_ace_fips_st;
    BOOLEAN Diff_aid_resclean_fipscounty;
    BOOLEAN Diff_aid_resclean_geo_lat;
    BOOLEAN Diff_aid_resclean_geo_long;
    BOOLEAN Diff_aid_resclean_msa;
    BOOLEAN Diff_aid_resclean_geo_blk;
    BOOLEAN Diff_aid_resclean_geo_match;
    BOOLEAN Diff_aid_resclean_err_stat;
    BOOLEAN Diff_aid_mailclean_prim_range;
    BOOLEAN Diff_aid_mailclean_predir;
    BOOLEAN Diff_aid_mailclean_prim_name;
    BOOLEAN Diff_aid_mailclean_addr_suffix;
    BOOLEAN Diff_aid_mailclean_postdir;
    BOOLEAN Diff_aid_mailclean_unit_desig;
    BOOLEAN Diff_aid_mailclean_sec_range;
    BOOLEAN Diff_aid_mailclean_p_city_name;
    BOOLEAN Diff_aid_mailclean_v_city_name;
    BOOLEAN Diff_aid_mailclean_st;
    BOOLEAN Diff_aid_mailclean_zip;
    BOOLEAN Diff_aid_mailclean_zip4;
    BOOLEAN Diff_aid_mailclean_cart;
    BOOLEAN Diff_aid_mailclean_cr_sort_sz;
    BOOLEAN Diff_aid_mailclean_lot;
    BOOLEAN Diff_aid_mailclean_lot_order;
    BOOLEAN Diff_aid_mailclean_dpbc;
    BOOLEAN Diff_aid_mailclean_chk_digit;
    BOOLEAN Diff_aid_mailclean_record_type;
    BOOLEAN Diff_aid_mailclean_ace_fips_st;
    BOOLEAN Diff_aid_mailclean_fipscounty;
    BOOLEAN Diff_aid_mailclean_geo_lat;
    BOOLEAN Diff_aid_mailclean_geo_long;
    BOOLEAN Diff_aid_mailclean_msa;
    BOOLEAN Diff_aid_mailclean_geo_blk;
    BOOLEAN Diff_aid_mailclean_geo_match;
    BOOLEAN Diff_aid_mailclean_err_stat;
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
    BOOLEAN Diff_cass_prim_range;
    BOOLEAN Diff_cass_predir;
    BOOLEAN Diff_cass_prim_name;
    BOOLEAN Diff_cass_addr_suffix;
    BOOLEAN Diff_cass_postdir;
    BOOLEAN Diff_cass_unit_desig;
    BOOLEAN Diff_cass_sec_range;
    BOOLEAN Diff_cass_p_city_name;
    BOOLEAN Diff_cass_v_city_name;
    BOOLEAN Diff_cass_st;
    BOOLEAN Diff_cass_ace_zip;
    BOOLEAN Diff_cass_zip4;
    BOOLEAN Diff_cass_cart;
    BOOLEAN Diff_cass_cr_sort_sz;
    BOOLEAN Diff_cass_lot;
    BOOLEAN Diff_cass_lot_order;
    BOOLEAN Diff_cass_dpbc;
    BOOLEAN Diff_cass_chk_digit;
    BOOLEAN Diff_cass_record_type;
    BOOLEAN Diff_cass_ace_fips_st;
    BOOLEAN Diff_cass_fipscounty;
    BOOLEAN Diff_cass_geo_lat;
    BOOLEAN Diff_cass_geo_long;
    BOOLEAN Diff_cass_msa;
    BOOLEAN Diff_cass_geo_blk;
    BOOLEAN Diff_cass_geo_match;
    BOOLEAN Diff_cass_err_stat;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_seqnum := le.append_seqnum <> ri.append_seqnum;
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
    SELF.Diff_dob_str_in := le.dob_str_in <> ri.dob_str_in;
    SELF.Diff_agecat := le.agecat <> ri.agecat;
    SELF.Diff_headhousehold := le.headhousehold <> ri.headhousehold;
    SELF.Diff_place_of_birth := le.place_of_birth <> ri.place_of_birth;
    SELF.Diff_occupation := le.occupation <> ri.occupation;
    SELF.Diff_maiden_name := le.maiden_name <> ri.maiden_name;
    SELF.Diff_motorvoterid := le.motorvoterid <> ri.motorvoterid;
    SELF.Diff_regsource := le.regsource <> ri.regsource;
    SELF.Diff_regdate_in := le.regdate_in <> ri.regdate_in;
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
    SELF.Diff_dateofcontr_in := le.dateofcontr_in <> ri.dateofcontr_in;
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
    SELF.Diff_lastdayvote_in := le.lastdayvote_in <> ri.lastdayvote_in;
    SELF.Diff_historyfiller := le.historyfiller <> ri.historyfiller;
    SELF.Diff_huntfishperm := le.huntfishperm <> ri.huntfishperm;
    SELF.Diff_datelicense_in := le.datelicense_in <> ri.datelicense_in;
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
    SELF.Diff_boatindexnum := le.boatindexnum <> ri.boatindexnum;
    SELF.Diff_boatcoowner := le.boatcoowner <> ri.boatcoowner;
    SELF.Diff_hullidnum := le.hullidnum <> ri.hullidnum;
    SELF.Diff_yearmade := le.yearmade <> ri.yearmade;
    SELF.Diff_model := le.model <> ri.model;
    SELF.Diff_manufacturer := le.manufacturer <> ri.manufacturer;
    SELF.Diff_lengt := le.lengt <> ri.lengt;
    SELF.Diff_hullconstruct := le.hullconstruct <> ri.hullconstruct;
    SELF.Diff_primuse := le.primuse <> ri.primuse;
    SELF.Diff_fueltype := le.fueltype <> ri.fueltype;
    SELF.Diff_propulsion := le.propulsion <> ri.propulsion;
    SELF.Diff_modeltype := le.modeltype <> ri.modeltype;
    SELF.Diff_regexpdate_in := le.regexpdate_in <> ri.regexpdate_in;
    SELF.Diff_titlenum := le.titlenum <> ri.titlenum;
    SELF.Diff_stprimuse := le.stprimuse <> ri.stprimuse;
    SELF.Diff_titlestatus := le.titlestatus <> ri.titlestatus;
    SELF.Diff_vessel := le.vessel <> ri.vessel;
    SELF.Diff_specreg := le.specreg <> ri.specreg;
    SELF.Diff_boatfill1 := le.boatfill1 <> ri.boatfill1;
    SELF.Diff_boatfill2 := le.boatfill2 <> ri.boatfill2;
    SELF.Diff_boatfill3 := le.boatfill3 <> ri.boatfill3;
    SELF.Diff_ccwpermnum := le.ccwpermnum <> ri.ccwpermnum;
    SELF.Diff_ccwweapontype := le.ccwweapontype <> ri.ccwweapontype;
    SELF.Diff_ccwregdate_in := le.ccwregdate_in <> ri.ccwregdate_in;
    SELF.Diff_ccwexpdate_in := le.ccwexpdate_in <> ri.ccwexpdate_in;
    SELF.Diff_ccwpermtype := le.ccwpermtype <> ri.ccwpermtype;
    SELF.Diff_ccwfill1 := le.ccwfill1 <> ri.ccwfill1;
    SELF.Diff_ccwfill2 := le.ccwfill2 <> ri.ccwfill2;
    SELF.Diff_ccwfill3 := le.ccwfill3 <> ri.ccwfill3;
    SELF.Diff_ccwfill4 := le.ccwfill4 <> ri.ccwfill4;
    SELF.Diff_miscfill1 := le.miscfill1 <> ri.miscfill1;
    SELF.Diff_miscfill2 := le.miscfill2 <> ri.miscfill2;
    SELF.Diff_miscfill3 := le.miscfill3 <> ri.miscfill3;
    SELF.Diff_miscfill4 := le.miscfill4 <> ri.miscfill4;
    SELF.Diff_miscfill5 := le.miscfill5 <> ri.miscfill5;
    SELF.Diff_fillerother1 := le.fillerother1 <> ri.fillerother1;
    SELF.Diff_fillerother2 := le.fillerother2 <> ri.fillerother2;
    SELF.Diff_fillerother3 := le.fillerother3 <> ri.fillerother3;
    SELF.Diff_fillerother4 := le.fillerother4 <> ri.fillerother4;
    SELF.Diff_fillerother5 := le.fillerother5 <> ri.fillerother5;
    SELF.Diff_fillerother6 := le.fillerother6 <> ri.fillerother6;
    SELF.Diff_fillerother7 := le.fillerother7 <> ri.fillerother7;
    SELF.Diff_fillerother8 := le.fillerother8 <> ri.fillerother8;
    SELF.Diff_fillerother9 := le.fillerother9 <> ri.fillerother9;
    SELF.Diff_fillerother10 := le.fillerother10 <> ri.fillerother10;
    SELF.Diff_eor := le.eor <> ri.eor;
    SELF.Diff_stuff := le.stuff <> ri.stuff;
    SELF.Diff_dob_str := le.dob_str <> ri.dob_str;
    SELF.Diff_regdate := le.regdate <> ri.regdate;
    SELF.Diff_dateofcontr := le.dateofcontr <> ri.dateofcontr;
    SELF.Diff_lastdayvote := le.lastdayvote <> ri.lastdayvote;
    SELF.Diff_datelicense := le.datelicense <> ri.datelicense;
    SELF.Diff_regexpdate := le.regexpdate <> ri.regexpdate;
    SELF.Diff_ccwregdate := le.ccwregdate <> ri.ccwregdate;
    SELF.Diff_ccwexpdate := le.ccwexpdate <> ri.ccwexpdate;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_score_on_input := le.score_on_input <> ri.score_on_input;
    SELF.Diff_append_prep_resaddress1 := le.append_prep_resaddress1 <> ri.append_prep_resaddress1;
    SELF.Diff_append_prep_resaddress2 := le.append_prep_resaddress2 <> ri.append_prep_resaddress2;
    SELF.Diff_append_resrawaid := le.append_resrawaid <> ri.append_resrawaid;
    SELF.Diff_append_prep_mailaddress1 := le.append_prep_mailaddress1 <> ri.append_prep_mailaddress1;
    SELF.Diff_append_prep_mailaddress2 := le.append_prep_mailaddress2 <> ri.append_prep_mailaddress2;
    SELF.Diff_append_mailrawaid := le.append_mailrawaid <> ri.append_mailrawaid;
    SELF.Diff_append_prep_cassaddress1 := le.append_prep_cassaddress1 <> ri.append_prep_cassaddress1;
    SELF.Diff_append_prep_cassaddress2 := le.append_prep_cassaddress2 <> ri.append_prep_cassaddress2;
    SELF.Diff_append_cassrawaid := le.append_cassrawaid <> ri.append_cassrawaid;
    SELF.Diff_aid_resclean_prim_range := le.aid_resclean_prim_range <> ri.aid_resclean_prim_range;
    SELF.Diff_aid_resclean_predir := le.aid_resclean_predir <> ri.aid_resclean_predir;
    SELF.Diff_aid_resclean_prim_name := le.aid_resclean_prim_name <> ri.aid_resclean_prim_name;
    SELF.Diff_aid_resclean_addr_suffix := le.aid_resclean_addr_suffix <> ri.aid_resclean_addr_suffix;
    SELF.Diff_aid_resclean_postdir := le.aid_resclean_postdir <> ri.aid_resclean_postdir;
    SELF.Diff_aid_resclean_unit_desig := le.aid_resclean_unit_desig <> ri.aid_resclean_unit_desig;
    SELF.Diff_aid_resclean_sec_range := le.aid_resclean_sec_range <> ri.aid_resclean_sec_range;
    SELF.Diff_aid_resclean_p_city_name := le.aid_resclean_p_city_name <> ri.aid_resclean_p_city_name;
    SELF.Diff_aid_resclean_v_city_name := le.aid_resclean_v_city_name <> ri.aid_resclean_v_city_name;
    SELF.Diff_aid_resclean_st := le.aid_resclean_st <> ri.aid_resclean_st;
    SELF.Diff_aid_resclean_zip := le.aid_resclean_zip <> ri.aid_resclean_zip;
    SELF.Diff_aid_resclean_zip4 := le.aid_resclean_zip4 <> ri.aid_resclean_zip4;
    SELF.Diff_aid_resclean_cart := le.aid_resclean_cart <> ri.aid_resclean_cart;
    SELF.Diff_aid_resclean_cr_sort_sz := le.aid_resclean_cr_sort_sz <> ri.aid_resclean_cr_sort_sz;
    SELF.Diff_aid_resclean_lot := le.aid_resclean_lot <> ri.aid_resclean_lot;
    SELF.Diff_aid_resclean_lot_order := le.aid_resclean_lot_order <> ri.aid_resclean_lot_order;
    SELF.Diff_aid_resclean_dpbc := le.aid_resclean_dpbc <> ri.aid_resclean_dpbc;
    SELF.Diff_aid_resclean_chk_digit := le.aid_resclean_chk_digit <> ri.aid_resclean_chk_digit;
    SELF.Diff_aid_resclean_record_type := le.aid_resclean_record_type <> ri.aid_resclean_record_type;
    SELF.Diff_aid_resclean_ace_fips_st := le.aid_resclean_ace_fips_st <> ri.aid_resclean_ace_fips_st;
    SELF.Diff_aid_resclean_fipscounty := le.aid_resclean_fipscounty <> ri.aid_resclean_fipscounty;
    SELF.Diff_aid_resclean_geo_lat := le.aid_resclean_geo_lat <> ri.aid_resclean_geo_lat;
    SELF.Diff_aid_resclean_geo_long := le.aid_resclean_geo_long <> ri.aid_resclean_geo_long;
    SELF.Diff_aid_resclean_msa := le.aid_resclean_msa <> ri.aid_resclean_msa;
    SELF.Diff_aid_resclean_geo_blk := le.aid_resclean_geo_blk <> ri.aid_resclean_geo_blk;
    SELF.Diff_aid_resclean_geo_match := le.aid_resclean_geo_match <> ri.aid_resclean_geo_match;
    SELF.Diff_aid_resclean_err_stat := le.aid_resclean_err_stat <> ri.aid_resclean_err_stat;
    SELF.Diff_aid_mailclean_prim_range := le.aid_mailclean_prim_range <> ri.aid_mailclean_prim_range;
    SELF.Diff_aid_mailclean_predir := le.aid_mailclean_predir <> ri.aid_mailclean_predir;
    SELF.Diff_aid_mailclean_prim_name := le.aid_mailclean_prim_name <> ri.aid_mailclean_prim_name;
    SELF.Diff_aid_mailclean_addr_suffix := le.aid_mailclean_addr_suffix <> ri.aid_mailclean_addr_suffix;
    SELF.Diff_aid_mailclean_postdir := le.aid_mailclean_postdir <> ri.aid_mailclean_postdir;
    SELF.Diff_aid_mailclean_unit_desig := le.aid_mailclean_unit_desig <> ri.aid_mailclean_unit_desig;
    SELF.Diff_aid_mailclean_sec_range := le.aid_mailclean_sec_range <> ri.aid_mailclean_sec_range;
    SELF.Diff_aid_mailclean_p_city_name := le.aid_mailclean_p_city_name <> ri.aid_mailclean_p_city_name;
    SELF.Diff_aid_mailclean_v_city_name := le.aid_mailclean_v_city_name <> ri.aid_mailclean_v_city_name;
    SELF.Diff_aid_mailclean_st := le.aid_mailclean_st <> ri.aid_mailclean_st;
    SELF.Diff_aid_mailclean_zip := le.aid_mailclean_zip <> ri.aid_mailclean_zip;
    SELF.Diff_aid_mailclean_zip4 := le.aid_mailclean_zip4 <> ri.aid_mailclean_zip4;
    SELF.Diff_aid_mailclean_cart := le.aid_mailclean_cart <> ri.aid_mailclean_cart;
    SELF.Diff_aid_mailclean_cr_sort_sz := le.aid_mailclean_cr_sort_sz <> ri.aid_mailclean_cr_sort_sz;
    SELF.Diff_aid_mailclean_lot := le.aid_mailclean_lot <> ri.aid_mailclean_lot;
    SELF.Diff_aid_mailclean_lot_order := le.aid_mailclean_lot_order <> ri.aid_mailclean_lot_order;
    SELF.Diff_aid_mailclean_dpbc := le.aid_mailclean_dpbc <> ri.aid_mailclean_dpbc;
    SELF.Diff_aid_mailclean_chk_digit := le.aid_mailclean_chk_digit <> ri.aid_mailclean_chk_digit;
    SELF.Diff_aid_mailclean_record_type := le.aid_mailclean_record_type <> ri.aid_mailclean_record_type;
    SELF.Diff_aid_mailclean_ace_fips_st := le.aid_mailclean_ace_fips_st <> ri.aid_mailclean_ace_fips_st;
    SELF.Diff_aid_mailclean_fipscounty := le.aid_mailclean_fipscounty <> ri.aid_mailclean_fipscounty;
    SELF.Diff_aid_mailclean_geo_lat := le.aid_mailclean_geo_lat <> ri.aid_mailclean_geo_lat;
    SELF.Diff_aid_mailclean_geo_long := le.aid_mailclean_geo_long <> ri.aid_mailclean_geo_long;
    SELF.Diff_aid_mailclean_msa := le.aid_mailclean_msa <> ri.aid_mailclean_msa;
    SELF.Diff_aid_mailclean_geo_blk := le.aid_mailclean_geo_blk <> ri.aid_mailclean_geo_blk;
    SELF.Diff_aid_mailclean_geo_match := le.aid_mailclean_geo_match <> ri.aid_mailclean_geo_match;
    SELF.Diff_aid_mailclean_err_stat := le.aid_mailclean_err_stat <> ri.aid_mailclean_err_stat;
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
    SELF.Diff_cass_prim_range := le.cass_prim_range <> ri.cass_prim_range;
    SELF.Diff_cass_predir := le.cass_predir <> ri.cass_predir;
    SELF.Diff_cass_prim_name := le.cass_prim_name <> ri.cass_prim_name;
    SELF.Diff_cass_addr_suffix := le.cass_addr_suffix <> ri.cass_addr_suffix;
    SELF.Diff_cass_postdir := le.cass_postdir <> ri.cass_postdir;
    SELF.Diff_cass_unit_desig := le.cass_unit_desig <> ri.cass_unit_desig;
    SELF.Diff_cass_sec_range := le.cass_sec_range <> ri.cass_sec_range;
    SELF.Diff_cass_p_city_name := le.cass_p_city_name <> ri.cass_p_city_name;
    SELF.Diff_cass_v_city_name := le.cass_v_city_name <> ri.cass_v_city_name;
    SELF.Diff_cass_st := le.cass_st <> ri.cass_st;
    SELF.Diff_cass_ace_zip := le.cass_ace_zip <> ri.cass_ace_zip;
    SELF.Diff_cass_zip4 := le.cass_zip4 <> ri.cass_zip4;
    SELF.Diff_cass_cart := le.cass_cart <> ri.cass_cart;
    SELF.Diff_cass_cr_sort_sz := le.cass_cr_sort_sz <> ri.cass_cr_sort_sz;
    SELF.Diff_cass_lot := le.cass_lot <> ri.cass_lot;
    SELF.Diff_cass_lot_order := le.cass_lot_order <> ri.cass_lot_order;
    SELF.Diff_cass_dpbc := le.cass_dpbc <> ri.cass_dpbc;
    SELF.Diff_cass_chk_digit := le.cass_chk_digit <> ri.cass_chk_digit;
    SELF.Diff_cass_record_type := le.cass_record_type <> ri.cass_record_type;
    SELF.Diff_cass_ace_fips_st := le.cass_ace_fips_st <> ri.cass_ace_fips_st;
    SELF.Diff_cass_fipscounty := le.cass_fipscounty <> ri.cass_fipscounty;
    SELF.Diff_cass_geo_lat := le.cass_geo_lat <> ri.cass_geo_lat;
    SELF.Diff_cass_geo_long := le.cass_geo_long <> ri.cass_geo_long;
    SELF.Diff_cass_msa := le.cass_msa <> ri.cass_msa;
    SELF.Diff_cass_geo_blk := le.cass_geo_blk <> ri.cass_geo_blk;
    SELF.Diff_cass_geo_match := le.cass_geo_match <> ri.cass_geo_match;
    SELF.Diff_cass_err_stat := le.cass_err_stat <> ri.cass_err_stat;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_seqnum,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_did_out,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_file_acquired_date,1,0)+ IF( SELF.Diff__use,1,0)+ IF( SELF.Diff_title_in,1,0)+ IF( SELF.Diff_lname_in,1,0)+ IF( SELF.Diff_fname_in,1,0)+ IF( SELF.Diff_mname_in,1,0)+ IF( SELF.Diff_maiden_prior,1,0)+ IF( SELF.Diff_name_suffix_in,1,0)+ IF( SELF.Diff_votefiller,1,0)+ IF( SELF.Diff_source_voterid,1,0)+ IF( SELF.Diff_dob_str_in,1,0)+ IF( SELF.Diff_agecat,1,0)+ IF( SELF.Diff_headhousehold,1,0)+ IF( SELF.Diff_place_of_birth,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_maiden_name,1,0)+ IF( SELF.Diff_motorvoterid,1,0)+ IF( SELF.Diff_regsource,1,0)+ IF( SELF.Diff_regdate_in,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_poliparty,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_other_phone,1,0)+ IF( SELF.Diff_active_status,1,0)+ IF( SELF.Diff_votefiller2,1,0)+ IF( SELF.Diff_active_other,1,0)+ IF( SELF.Diff_voterstatus,1,0)+ IF( SELF.Diff_resaddr1,1,0)+ IF( SELF.Diff_resaddr2,1,0)+ IF( SELF.Diff_res_city,1,0)+ IF( SELF.Diff_res_state,1,0)+ IF( SELF.Diff_res_zip,1,0)+ IF( SELF.Diff_res_county,1,0)+ IF( SELF.Diff_mail_addr1,1,0)+ IF( SELF.Diff_mail_addr2,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_addr_filler1,1,0)+ IF( SELF.Diff_addr_filler2,1,0)+ IF( SELF.Diff_city_filler,1,0)+ IF( SELF.Diff_state_filler,1,0)+ IF( SELF.Diff_zip_filler,1,0)+ IF( SELF.Diff_county_filler,1,0)+ IF( SELF.Diff_towncode,1,0)+ IF( SELF.Diff_distcode,1,0)+ IF( SELF.Diff_countycode,1,0)+ IF( SELF.Diff_schoolcode,1,0)+ IF( SELF.Diff_cityinout,1,0)+ IF( SELF.Diff_spec_dist1,1,0)+ IF( SELF.Diff_spec_dist2,1,0)+ IF( SELF.Diff_precinct1,1,0)+ IF( SELF.Diff_precinct2,1,0)+ IF( SELF.Diff_precinct3,1,0)+ IF( SELF.Diff_villageprecinct,1,0)+ IF( SELF.Diff_schoolprecinct,1,0)+ IF( SELF.Diff_ward,1,0)+ IF( SELF.Diff_precinct_citytown,1,0)+ IF( SELF.Diff_ancsmdindc,1,0)+ IF( SELF.Diff_citycouncildist,1,0)+ IF( SELF.Diff_countycommdist,1,0)+ IF( SELF.Diff_statehouse,1,0)+ IF( SELF.Diff_statesenate,1,0)+ IF( SELF.Diff_ushouse,1,0)+ IF( SELF.Diff_elemschooldist,1,0)+ IF( SELF.Diff_schooldist,1,0)+ IF( SELF.Diff_schoolfiller,1,0)+ IF( SELF.Diff_commcolldist,1,0)+ IF( SELF.Diff_dist_filler,1,0)+ IF( SELF.Diff_municipal,1,0)+ IF( SELF.Diff_villagedist,1,0)+ IF( SELF.Diff_policejury,1,0)+ IF( SELF.Diff_policedist,1,0)+ IF( SELF.Diff_publicservcomm,1,0)+ IF( SELF.Diff_rescue,1,0)+ IF( SELF.Diff_fire,1,0)+ IF( SELF.Diff_sanitary,1,0)+ IF( SELF.Diff_sewerdist,1,0)+ IF( SELF.Diff_waterdist,1,0)+ IF( SELF.Diff_mosquitodist,1,0)+ IF( SELF.Diff_taxdist,1,0)+ IF( SELF.Diff_supremecourt,1,0)+ IF( SELF.Diff_justiceofpeace,1,0)+ IF( SELF.Diff_judicialdist,1,0)+ IF( SELF.Diff_superiorctdist,1,0)+ IF( SELF.Diff_appealsct,1,0)+ IF( SELF.Diff_courtfiller,1,0)+ IF( SELF.Diff_contributorparty,1,0)+ IF( SELF.Diff_recptparty,1,0)+ IF( SELF.Diff_dateofcontr_in,1,0)+ IF( SELF.Diff_dollaramt,1,0)+ IF( SELF.Diff_officecontto,1,0)+ IF( SELF.Diff_cumuldollaramt,1,0)+ IF( SELF.Diff_contfiller1,1,0)+ IF( SELF.Diff_contfiller2,1,0)+ IF( SELF.Diff_conttype,1,0)+ IF( SELF.Diff_contfiller3,1,0)+ IF( SELF.Diff_primary02,1,0)+ IF( SELF.Diff_special02,1,0)+ IF( SELF.Diff_other02,1,0)+ IF( SELF.Diff_special202,1,0)+ IF( SELF.Diff_general02,1,0)+ IF( SELF.Diff_primary01,1,0)+ IF( SELF.Diff_special01,1,0)+ IF( SELF.Diff_other01,1,0)+ IF( SELF.Diff_special201,1,0)+ IF( SELF.Diff_general01,1,0)+ IF( SELF.Diff_pres00,1,0)+ IF( SELF.Diff_primary00,1,0)+ IF( SELF.Diff_special00,1,0)+ IF( SELF.Diff_other00,1,0)+ IF( SELF.Diff_special200,1,0)+ IF( SELF.Diff_general00,1,0)+ IF( SELF.Diff_primary99,1,0)+ IF( SELF.Diff_special99,1,0)+ IF( SELF.Diff_other99,1,0)+ IF( SELF.Diff_special299,1,0)+ IF( SELF.Diff_general99,1,0)+ IF( SELF.Diff_primary98,1,0)+ IF( SELF.Diff_special98,1,0)+ IF( SELF.Diff_other98,1,0)+ IF( SELF.Diff_special298,1,0)+ IF( SELF.Diff_general98,1,0)+ IF( SELF.Diff_primary97,1,0)+ IF( SELF.Diff_special97,1,0)+ IF( SELF.Diff_other97,1,0)+ IF( SELF.Diff_special297,1,0)+ IF( SELF.Diff_general97,1,0)+ IF( SELF.Diff_pres96,1,0)+ IF( SELF.Diff_primary96,1,0)+ IF( SELF.Diff_special96,1,0)+ IF( SELF.Diff_other96,1,0)+ IF( SELF.Diff_special296,1,0)+ IF( SELF.Diff_general96,1,0)+ IF( SELF.Diff_lastdayvote_in,1,0)+ IF( SELF.Diff_historyfiller,1,0)+ IF( SELF.Diff_huntfishperm,1,0)+ IF( SELF.Diff_datelicense_in,1,0)+ IF( SELF.Diff_homestate,1,0)+ IF( SELF.Diff_resident,1,0)+ IF( SELF.Diff_nonresident,1,0)+ IF( SELF.Diff_hunt,1,0)+ IF( SELF.Diff_fish,1,0)+ IF( SELF.Diff_combosuper,1,0)+ IF( SELF.Diff_sportsman,1,0)+ IF( SELF.Diff_trap,1,0)+ IF( SELF.Diff_archery,1,0)+ IF( SELF.Diff_muzzle,1,0)+ IF( SELF.Diff_drawing,1,0)+ IF( SELF.Diff_day1,1,0)+ IF( SELF.Diff_day3,1,0)+ IF( SELF.Diff_day7,1,0)+ IF( SELF.Diff_day14to15,1,0)+ IF( SELF.Diff_dayfiller,1,0)+ IF( SELF.Diff_seasonannual,1,0)+ IF( SELF.Diff_lifetimepermit,1,0)+ IF( SELF.Diff_landowner,1,0)+ IF( SELF.Diff_family,1,0)+ IF( SELF.Diff_junior,1,0)+ IF( SELF.Diff_seniorcit,1,0)+ IF( SELF.Diff_crewmemeber,1,0)+ IF( SELF.Diff_retarded,1,0)+ IF( SELF.Diff_indian,1,0)+ IF( SELF.Diff_serviceman,1,0)+ IF( SELF.Diff_disabled,1,0)+ IF( SELF.Diff_lowincome,1,0)+ IF( SELF.Diff_regioncounty,1,0)+ IF( SELF.Diff_blind,1,0)+ IF( SELF.Diff_huntfiller,1,0)+ IF( SELF.Diff_salmon,1,0)+ IF( SELF.Diff_freshwater,1,0)+ IF( SELF.Diff_saltwater,1,0)+ IF( SELF.Diff_lakesandresevoirs,1,0)+ IF( SELF.Diff_setlinefish,1,0)+ IF( SELF.Diff_trout,1,0)+ IF( SELF.Diff_fallfishing,1,0)+ IF( SELF.Diff_steelhead,1,0)+ IF( SELF.Diff_whitejubherring,1,0)+ IF( SELF.Diff_sturgeon,1,0)+ IF( SELF.Diff_shellfishcrab,1,0)+ IF( SELF.Diff_shellfishlobster,1,0)+ IF( SELF.Diff_deer,1,0)+ IF( SELF.Diff_bear,1,0)+ IF( SELF.Diff_elk,1,0)+ IF( SELF.Diff_moose,1,0)+ IF( SELF.Diff_buffalo,1,0)+ IF( SELF.Diff_antelope,1,0)+ IF( SELF.Diff_sikebull,1,0)+ IF( SELF.Diff_bighorn,1,0)+ IF( SELF.Diff_javelina,1,0)+ IF( SELF.Diff_cougar,1,0)+ IF( SELF.Diff_anterless,1,0)+ IF( SELF.Diff_pheasant,1,0)+ IF( SELF.Diff_goose,1,0)+ IF( SELF.Diff_duck,1,0)+ IF( SELF.Diff_turkey,1,0)+ IF( SELF.Diff_snowmobile,1,0)+ IF( SELF.Diff_biggame,1,0)+ IF( SELF.Diff_skipass,1,0)+ IF( SELF.Diff_migbird,1,0)+ IF( SELF.Diff_smallgame,1,0)+ IF( SELF.Diff_sturgeon2,1,0)+ IF( SELF.Diff_gun,1,0)+ IF( SELF.Diff_bonus,1,0)+ IF( SELF.Diff_lottery,1,0)+ IF( SELF.Diff_otherbirds,1,0)+ IF( SELF.Diff_huntfill1,1,0)+ IF( SELF.Diff_boatindexnum,1,0)+ IF( SELF.Diff_boatcoowner,1,0)+ IF( SELF.Diff_hullidnum,1,0)+ IF( SELF.Diff_yearmade,1,0)+ IF( SELF.Diff_model,1,0)+ IF( SELF.Diff_manufacturer,1,0)+ IF( SELF.Diff_lengt,1,0)+ IF( SELF.Diff_hullconstruct,1,0)+ IF( SELF.Diff_primuse,1,0)+ IF( SELF.Diff_fueltype,1,0)+ IF( SELF.Diff_propulsion,1,0)+ IF( SELF.Diff_modeltype,1,0)+ IF( SELF.Diff_regexpdate_in,1,0)+ IF( SELF.Diff_titlenum,1,0)+ IF( SELF.Diff_stprimuse,1,0)+ IF( SELF.Diff_titlestatus,1,0)+ IF( SELF.Diff_vessel,1,0)+ IF( SELF.Diff_specreg,1,0)+ IF( SELF.Diff_boatfill1,1,0)+ IF( SELF.Diff_boatfill2,1,0)+ IF( SELF.Diff_boatfill3,1,0)+ IF( SELF.Diff_ccwpermnum,1,0)+ IF( SELF.Diff_ccwweapontype,1,0)+ IF( SELF.Diff_ccwregdate_in,1,0)+ IF( SELF.Diff_ccwexpdate_in,1,0)+ IF( SELF.Diff_ccwpermtype,1,0)+ IF( SELF.Diff_ccwfill1,1,0)+ IF( SELF.Diff_ccwfill2,1,0)+ IF( SELF.Diff_ccwfill3,1,0)+ IF( SELF.Diff_ccwfill4,1,0)+ IF( SELF.Diff_miscfill1,1,0)+ IF( SELF.Diff_miscfill2,1,0)+ IF( SELF.Diff_miscfill3,1,0)+ IF( SELF.Diff_miscfill4,1,0)+ IF( SELF.Diff_miscfill5,1,0)+ IF( SELF.Diff_fillerother1,1,0)+ IF( SELF.Diff_fillerother2,1,0)+ IF( SELF.Diff_fillerother3,1,0)+ IF( SELF.Diff_fillerother4,1,0)+ IF( SELF.Diff_fillerother5,1,0)+ IF( SELF.Diff_fillerother6,1,0)+ IF( SELF.Diff_fillerother7,1,0)+ IF( SELF.Diff_fillerother8,1,0)+ IF( SELF.Diff_fillerother9,1,0)+ IF( SELF.Diff_fillerother10,1,0)+ IF( SELF.Diff_eor,1,0)+ IF( SELF.Diff_stuff,1,0)+ IF( SELF.Diff_dob_str,1,0)+ IF( SELF.Diff_regdate,1,0)+ IF( SELF.Diff_dateofcontr,1,0)+ IF( SELF.Diff_lastdayvote,1,0)+ IF( SELF.Diff_datelicense,1,0)+ IF( SELF.Diff_regexpdate,1,0)+ IF( SELF.Diff_ccwregdate,1,0)+ IF( SELF.Diff_ccwexpdate,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_score_on_input,1,0)+ IF( SELF.Diff_append_prep_resaddress1,1,0)+ IF( SELF.Diff_append_prep_resaddress2,1,0)+ IF( SELF.Diff_append_resrawaid,1,0)+ IF( SELF.Diff_append_prep_mailaddress1,1,0)+ IF( SELF.Diff_append_prep_mailaddress2,1,0)+ IF( SELF.Diff_append_mailrawaid,1,0)+ IF( SELF.Diff_append_prep_cassaddress1,1,0)+ IF( SELF.Diff_append_prep_cassaddress2,1,0)+ IF( SELF.Diff_append_cassrawaid,1,0)+ IF( SELF.Diff_aid_resclean_prim_range,1,0)+ IF( SELF.Diff_aid_resclean_predir,1,0)+ IF( SELF.Diff_aid_resclean_prim_name,1,0)+ IF( SELF.Diff_aid_resclean_addr_suffix,1,0)+ IF( SELF.Diff_aid_resclean_postdir,1,0)+ IF( SELF.Diff_aid_resclean_unit_desig,1,0)+ IF( SELF.Diff_aid_resclean_sec_range,1,0)+ IF( SELF.Diff_aid_resclean_p_city_name,1,0)+ IF( SELF.Diff_aid_resclean_v_city_name,1,0)+ IF( SELF.Diff_aid_resclean_st,1,0)+ IF( SELF.Diff_aid_resclean_zip,1,0)+ IF( SELF.Diff_aid_resclean_zip4,1,0)+ IF( SELF.Diff_aid_resclean_cart,1,0)+ IF( SELF.Diff_aid_resclean_cr_sort_sz,1,0)+ IF( SELF.Diff_aid_resclean_lot,1,0)+ IF( SELF.Diff_aid_resclean_lot_order,1,0)+ IF( SELF.Diff_aid_resclean_dpbc,1,0)+ IF( SELF.Diff_aid_resclean_chk_digit,1,0)+ IF( SELF.Diff_aid_resclean_record_type,1,0)+ IF( SELF.Diff_aid_resclean_ace_fips_st,1,0)+ IF( SELF.Diff_aid_resclean_fipscounty,1,0)+ IF( SELF.Diff_aid_resclean_geo_lat,1,0)+ IF( SELF.Diff_aid_resclean_geo_long,1,0)+ IF( SELF.Diff_aid_resclean_msa,1,0)+ IF( SELF.Diff_aid_resclean_geo_blk,1,0)+ IF( SELF.Diff_aid_resclean_geo_match,1,0)+ IF( SELF.Diff_aid_resclean_err_stat,1,0)+ IF( SELF.Diff_aid_mailclean_prim_range,1,0)+ IF( SELF.Diff_aid_mailclean_predir,1,0)+ IF( SELF.Diff_aid_mailclean_prim_name,1,0)+ IF( SELF.Diff_aid_mailclean_addr_suffix,1,0)+ IF( SELF.Diff_aid_mailclean_postdir,1,0)+ IF( SELF.Diff_aid_mailclean_unit_desig,1,0)+ IF( SELF.Diff_aid_mailclean_sec_range,1,0)+ IF( SELF.Diff_aid_mailclean_p_city_name,1,0)+ IF( SELF.Diff_aid_mailclean_v_city_name,1,0)+ IF( SELF.Diff_aid_mailclean_st,1,0)+ IF( SELF.Diff_aid_mailclean_zip,1,0)+ IF( SELF.Diff_aid_mailclean_zip4,1,0)+ IF( SELF.Diff_aid_mailclean_cart,1,0)+ IF( SELF.Diff_aid_mailclean_cr_sort_sz,1,0)+ IF( SELF.Diff_aid_mailclean_lot,1,0)+ IF( SELF.Diff_aid_mailclean_lot_order,1,0)+ IF( SELF.Diff_aid_mailclean_dpbc,1,0)+ IF( SELF.Diff_aid_mailclean_chk_digit,1,0)+ IF( SELF.Diff_aid_mailclean_record_type,1,0)+ IF( SELF.Diff_aid_mailclean_ace_fips_st,1,0)+ IF( SELF.Diff_aid_mailclean_fipscounty,1,0)+ IF( SELF.Diff_aid_mailclean_geo_lat,1,0)+ IF( SELF.Diff_aid_mailclean_geo_long,1,0)+ IF( SELF.Diff_aid_mailclean_msa,1,0)+ IF( SELF.Diff_aid_mailclean_geo_blk,1,0)+ IF( SELF.Diff_aid_mailclean_geo_match,1,0)+ IF( SELF.Diff_aid_mailclean_err_stat,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_ace_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dpbc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_record_type,1,0)+ IF( SELF.Diff_mail_ace_fips_st,1,0)+ IF( SELF.Diff_mail_fipscounty,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0)+ IF( SELF.Diff_cass_prim_range,1,0)+ IF( SELF.Diff_cass_predir,1,0)+ IF( SELF.Diff_cass_prim_name,1,0)+ IF( SELF.Diff_cass_addr_suffix,1,0)+ IF( SELF.Diff_cass_postdir,1,0)+ IF( SELF.Diff_cass_unit_desig,1,0)+ IF( SELF.Diff_cass_sec_range,1,0)+ IF( SELF.Diff_cass_p_city_name,1,0)+ IF( SELF.Diff_cass_v_city_name,1,0)+ IF( SELF.Diff_cass_st,1,0)+ IF( SELF.Diff_cass_ace_zip,1,0)+ IF( SELF.Diff_cass_zip4,1,0)+ IF( SELF.Diff_cass_cart,1,0)+ IF( SELF.Diff_cass_cr_sort_sz,1,0)+ IF( SELF.Diff_cass_lot,1,0)+ IF( SELF.Diff_cass_lot_order,1,0)+ IF( SELF.Diff_cass_dpbc,1,0)+ IF( SELF.Diff_cass_chk_digit,1,0)+ IF( SELF.Diff_cass_record_type,1,0)+ IF( SELF.Diff_cass_ace_fips_st,1,0)+ IF( SELF.Diff_cass_fipscounty,1,0)+ IF( SELF.Diff_cass_geo_lat,1,0)+ IF( SELF.Diff_cass_geo_long,1,0)+ IF( SELF.Diff_cass_msa,1,0)+ IF( SELF.Diff_cass_geo_blk,1,0)+ IF( SELF.Diff_cass_geo_match,1,0)+ IF( SELF.Diff_cass_err_stat,1,0);
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
    Count_Diff_append_seqnum := COUNT(GROUP,%Closest%.Diff_append_seqnum);
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
    Count_Diff_dob_str_in := COUNT(GROUP,%Closest%.Diff_dob_str_in);
    Count_Diff_agecat := COUNT(GROUP,%Closest%.Diff_agecat);
    Count_Diff_headhousehold := COUNT(GROUP,%Closest%.Diff_headhousehold);
    Count_Diff_place_of_birth := COUNT(GROUP,%Closest%.Diff_place_of_birth);
    Count_Diff_occupation := COUNT(GROUP,%Closest%.Diff_occupation);
    Count_Diff_maiden_name := COUNT(GROUP,%Closest%.Diff_maiden_name);
    Count_Diff_motorvoterid := COUNT(GROUP,%Closest%.Diff_motorvoterid);
    Count_Diff_regsource := COUNT(GROUP,%Closest%.Diff_regsource);
    Count_Diff_regdate_in := COUNT(GROUP,%Closest%.Diff_regdate_in);
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
    Count_Diff_dateofcontr_in := COUNT(GROUP,%Closest%.Diff_dateofcontr_in);
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
    Count_Diff_lastdayvote_in := COUNT(GROUP,%Closest%.Diff_lastdayvote_in);
    Count_Diff_historyfiller := COUNT(GROUP,%Closest%.Diff_historyfiller);
    Count_Diff_huntfishperm := COUNT(GROUP,%Closest%.Diff_huntfishperm);
    Count_Diff_datelicense_in := COUNT(GROUP,%Closest%.Diff_datelicense_in);
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
    Count_Diff_boatindexnum := COUNT(GROUP,%Closest%.Diff_boatindexnum);
    Count_Diff_boatcoowner := COUNT(GROUP,%Closest%.Diff_boatcoowner);
    Count_Diff_hullidnum := COUNT(GROUP,%Closest%.Diff_hullidnum);
    Count_Diff_yearmade := COUNT(GROUP,%Closest%.Diff_yearmade);
    Count_Diff_model := COUNT(GROUP,%Closest%.Diff_model);
    Count_Diff_manufacturer := COUNT(GROUP,%Closest%.Diff_manufacturer);
    Count_Diff_lengt := COUNT(GROUP,%Closest%.Diff_lengt);
    Count_Diff_hullconstruct := COUNT(GROUP,%Closest%.Diff_hullconstruct);
    Count_Diff_primuse := COUNT(GROUP,%Closest%.Diff_primuse);
    Count_Diff_fueltype := COUNT(GROUP,%Closest%.Diff_fueltype);
    Count_Diff_propulsion := COUNT(GROUP,%Closest%.Diff_propulsion);
    Count_Diff_modeltype := COUNT(GROUP,%Closest%.Diff_modeltype);
    Count_Diff_regexpdate_in := COUNT(GROUP,%Closest%.Diff_regexpdate_in);
    Count_Diff_titlenum := COUNT(GROUP,%Closest%.Diff_titlenum);
    Count_Diff_stprimuse := COUNT(GROUP,%Closest%.Diff_stprimuse);
    Count_Diff_titlestatus := COUNT(GROUP,%Closest%.Diff_titlestatus);
    Count_Diff_vessel := COUNT(GROUP,%Closest%.Diff_vessel);
    Count_Diff_specreg := COUNT(GROUP,%Closest%.Diff_specreg);
    Count_Diff_boatfill1 := COUNT(GROUP,%Closest%.Diff_boatfill1);
    Count_Diff_boatfill2 := COUNT(GROUP,%Closest%.Diff_boatfill2);
    Count_Diff_boatfill3 := COUNT(GROUP,%Closest%.Diff_boatfill3);
    Count_Diff_ccwpermnum := COUNT(GROUP,%Closest%.Diff_ccwpermnum);
    Count_Diff_ccwweapontype := COUNT(GROUP,%Closest%.Diff_ccwweapontype);
    Count_Diff_ccwregdate_in := COUNT(GROUP,%Closest%.Diff_ccwregdate_in);
    Count_Diff_ccwexpdate_in := COUNT(GROUP,%Closest%.Diff_ccwexpdate_in);
    Count_Diff_ccwpermtype := COUNT(GROUP,%Closest%.Diff_ccwpermtype);
    Count_Diff_ccwfill1 := COUNT(GROUP,%Closest%.Diff_ccwfill1);
    Count_Diff_ccwfill2 := COUNT(GROUP,%Closest%.Diff_ccwfill2);
    Count_Diff_ccwfill3 := COUNT(GROUP,%Closest%.Diff_ccwfill3);
    Count_Diff_ccwfill4 := COUNT(GROUP,%Closest%.Diff_ccwfill4);
    Count_Diff_miscfill1 := COUNT(GROUP,%Closest%.Diff_miscfill1);
    Count_Diff_miscfill2 := COUNT(GROUP,%Closest%.Diff_miscfill2);
    Count_Diff_miscfill3 := COUNT(GROUP,%Closest%.Diff_miscfill3);
    Count_Diff_miscfill4 := COUNT(GROUP,%Closest%.Diff_miscfill4);
    Count_Diff_miscfill5 := COUNT(GROUP,%Closest%.Diff_miscfill5);
    Count_Diff_fillerother1 := COUNT(GROUP,%Closest%.Diff_fillerother1);
    Count_Diff_fillerother2 := COUNT(GROUP,%Closest%.Diff_fillerother2);
    Count_Diff_fillerother3 := COUNT(GROUP,%Closest%.Diff_fillerother3);
    Count_Diff_fillerother4 := COUNT(GROUP,%Closest%.Diff_fillerother4);
    Count_Diff_fillerother5 := COUNT(GROUP,%Closest%.Diff_fillerother5);
    Count_Diff_fillerother6 := COUNT(GROUP,%Closest%.Diff_fillerother6);
    Count_Diff_fillerother7 := COUNT(GROUP,%Closest%.Diff_fillerother7);
    Count_Diff_fillerother8 := COUNT(GROUP,%Closest%.Diff_fillerother8);
    Count_Diff_fillerother9 := COUNT(GROUP,%Closest%.Diff_fillerother9);
    Count_Diff_fillerother10 := COUNT(GROUP,%Closest%.Diff_fillerother10);
    Count_Diff_eor := COUNT(GROUP,%Closest%.Diff_eor);
    Count_Diff_stuff := COUNT(GROUP,%Closest%.Diff_stuff);
    Count_Diff_dob_str := COUNT(GROUP,%Closest%.Diff_dob_str);
    Count_Diff_regdate := COUNT(GROUP,%Closest%.Diff_regdate);
    Count_Diff_dateofcontr := COUNT(GROUP,%Closest%.Diff_dateofcontr);
    Count_Diff_lastdayvote := COUNT(GROUP,%Closest%.Diff_lastdayvote);
    Count_Diff_datelicense := COUNT(GROUP,%Closest%.Diff_datelicense);
    Count_Diff_regexpdate := COUNT(GROUP,%Closest%.Diff_regexpdate);
    Count_Diff_ccwregdate := COUNT(GROUP,%Closest%.Diff_ccwregdate);
    Count_Diff_ccwexpdate := COUNT(GROUP,%Closest%.Diff_ccwexpdate);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_score_on_input := COUNT(GROUP,%Closest%.Diff_score_on_input);
    Count_Diff_append_prep_resaddress1 := COUNT(GROUP,%Closest%.Diff_append_prep_resaddress1);
    Count_Diff_append_prep_resaddress2 := COUNT(GROUP,%Closest%.Diff_append_prep_resaddress2);
    Count_Diff_append_resrawaid := COUNT(GROUP,%Closest%.Diff_append_resrawaid);
    Count_Diff_append_prep_mailaddress1 := COUNT(GROUP,%Closest%.Diff_append_prep_mailaddress1);
    Count_Diff_append_prep_mailaddress2 := COUNT(GROUP,%Closest%.Diff_append_prep_mailaddress2);
    Count_Diff_append_mailrawaid := COUNT(GROUP,%Closest%.Diff_append_mailrawaid);
    Count_Diff_append_prep_cassaddress1 := COUNT(GROUP,%Closest%.Diff_append_prep_cassaddress1);
    Count_Diff_append_prep_cassaddress2 := COUNT(GROUP,%Closest%.Diff_append_prep_cassaddress2);
    Count_Diff_append_cassrawaid := COUNT(GROUP,%Closest%.Diff_append_cassrawaid);
    Count_Diff_aid_resclean_prim_range := COUNT(GROUP,%Closest%.Diff_aid_resclean_prim_range);
    Count_Diff_aid_resclean_predir := COUNT(GROUP,%Closest%.Diff_aid_resclean_predir);
    Count_Diff_aid_resclean_prim_name := COUNT(GROUP,%Closest%.Diff_aid_resclean_prim_name);
    Count_Diff_aid_resclean_addr_suffix := COUNT(GROUP,%Closest%.Diff_aid_resclean_addr_suffix);
    Count_Diff_aid_resclean_postdir := COUNT(GROUP,%Closest%.Diff_aid_resclean_postdir);
    Count_Diff_aid_resclean_unit_desig := COUNT(GROUP,%Closest%.Diff_aid_resclean_unit_desig);
    Count_Diff_aid_resclean_sec_range := COUNT(GROUP,%Closest%.Diff_aid_resclean_sec_range);
    Count_Diff_aid_resclean_p_city_name := COUNT(GROUP,%Closest%.Diff_aid_resclean_p_city_name);
    Count_Diff_aid_resclean_v_city_name := COUNT(GROUP,%Closest%.Diff_aid_resclean_v_city_name);
    Count_Diff_aid_resclean_st := COUNT(GROUP,%Closest%.Diff_aid_resclean_st);
    Count_Diff_aid_resclean_zip := COUNT(GROUP,%Closest%.Diff_aid_resclean_zip);
    Count_Diff_aid_resclean_zip4 := COUNT(GROUP,%Closest%.Diff_aid_resclean_zip4);
    Count_Diff_aid_resclean_cart := COUNT(GROUP,%Closest%.Diff_aid_resclean_cart);
    Count_Diff_aid_resclean_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_aid_resclean_cr_sort_sz);
    Count_Diff_aid_resclean_lot := COUNT(GROUP,%Closest%.Diff_aid_resclean_lot);
    Count_Diff_aid_resclean_lot_order := COUNT(GROUP,%Closest%.Diff_aid_resclean_lot_order);
    Count_Diff_aid_resclean_dpbc := COUNT(GROUP,%Closest%.Diff_aid_resclean_dpbc);
    Count_Diff_aid_resclean_chk_digit := COUNT(GROUP,%Closest%.Diff_aid_resclean_chk_digit);
    Count_Diff_aid_resclean_record_type := COUNT(GROUP,%Closest%.Diff_aid_resclean_record_type);
    Count_Diff_aid_resclean_ace_fips_st := COUNT(GROUP,%Closest%.Diff_aid_resclean_ace_fips_st);
    Count_Diff_aid_resclean_fipscounty := COUNT(GROUP,%Closest%.Diff_aid_resclean_fipscounty);
    Count_Diff_aid_resclean_geo_lat := COUNT(GROUP,%Closest%.Diff_aid_resclean_geo_lat);
    Count_Diff_aid_resclean_geo_long := COUNT(GROUP,%Closest%.Diff_aid_resclean_geo_long);
    Count_Diff_aid_resclean_msa := COUNT(GROUP,%Closest%.Diff_aid_resclean_msa);
    Count_Diff_aid_resclean_geo_blk := COUNT(GROUP,%Closest%.Diff_aid_resclean_geo_blk);
    Count_Diff_aid_resclean_geo_match := COUNT(GROUP,%Closest%.Diff_aid_resclean_geo_match);
    Count_Diff_aid_resclean_err_stat := COUNT(GROUP,%Closest%.Diff_aid_resclean_err_stat);
    Count_Diff_aid_mailclean_prim_range := COUNT(GROUP,%Closest%.Diff_aid_mailclean_prim_range);
    Count_Diff_aid_mailclean_predir := COUNT(GROUP,%Closest%.Diff_aid_mailclean_predir);
    Count_Diff_aid_mailclean_prim_name := COUNT(GROUP,%Closest%.Diff_aid_mailclean_prim_name);
    Count_Diff_aid_mailclean_addr_suffix := COUNT(GROUP,%Closest%.Diff_aid_mailclean_addr_suffix);
    Count_Diff_aid_mailclean_postdir := COUNT(GROUP,%Closest%.Diff_aid_mailclean_postdir);
    Count_Diff_aid_mailclean_unit_desig := COUNT(GROUP,%Closest%.Diff_aid_mailclean_unit_desig);
    Count_Diff_aid_mailclean_sec_range := COUNT(GROUP,%Closest%.Diff_aid_mailclean_sec_range);
    Count_Diff_aid_mailclean_p_city_name := COUNT(GROUP,%Closest%.Diff_aid_mailclean_p_city_name);
    Count_Diff_aid_mailclean_v_city_name := COUNT(GROUP,%Closest%.Diff_aid_mailclean_v_city_name);
    Count_Diff_aid_mailclean_st := COUNT(GROUP,%Closest%.Diff_aid_mailclean_st);
    Count_Diff_aid_mailclean_zip := COUNT(GROUP,%Closest%.Diff_aid_mailclean_zip);
    Count_Diff_aid_mailclean_zip4 := COUNT(GROUP,%Closest%.Diff_aid_mailclean_zip4);
    Count_Diff_aid_mailclean_cart := COUNT(GROUP,%Closest%.Diff_aid_mailclean_cart);
    Count_Diff_aid_mailclean_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_aid_mailclean_cr_sort_sz);
    Count_Diff_aid_mailclean_lot := COUNT(GROUP,%Closest%.Diff_aid_mailclean_lot);
    Count_Diff_aid_mailclean_lot_order := COUNT(GROUP,%Closest%.Diff_aid_mailclean_lot_order);
    Count_Diff_aid_mailclean_dpbc := COUNT(GROUP,%Closest%.Diff_aid_mailclean_dpbc);
    Count_Diff_aid_mailclean_chk_digit := COUNT(GROUP,%Closest%.Diff_aid_mailclean_chk_digit);
    Count_Diff_aid_mailclean_record_type := COUNT(GROUP,%Closest%.Diff_aid_mailclean_record_type);
    Count_Diff_aid_mailclean_ace_fips_st := COUNT(GROUP,%Closest%.Diff_aid_mailclean_ace_fips_st);
    Count_Diff_aid_mailclean_fipscounty := COUNT(GROUP,%Closest%.Diff_aid_mailclean_fipscounty);
    Count_Diff_aid_mailclean_geo_lat := COUNT(GROUP,%Closest%.Diff_aid_mailclean_geo_lat);
    Count_Diff_aid_mailclean_geo_long := COUNT(GROUP,%Closest%.Diff_aid_mailclean_geo_long);
    Count_Diff_aid_mailclean_msa := COUNT(GROUP,%Closest%.Diff_aid_mailclean_msa);
    Count_Diff_aid_mailclean_geo_blk := COUNT(GROUP,%Closest%.Diff_aid_mailclean_geo_blk);
    Count_Diff_aid_mailclean_geo_match := COUNT(GROUP,%Closest%.Diff_aid_mailclean_geo_match);
    Count_Diff_aid_mailclean_err_stat := COUNT(GROUP,%Closest%.Diff_aid_mailclean_err_stat);
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
    Count_Diff_cass_prim_range := COUNT(GROUP,%Closest%.Diff_cass_prim_range);
    Count_Diff_cass_predir := COUNT(GROUP,%Closest%.Diff_cass_predir);
    Count_Diff_cass_prim_name := COUNT(GROUP,%Closest%.Diff_cass_prim_name);
    Count_Diff_cass_addr_suffix := COUNT(GROUP,%Closest%.Diff_cass_addr_suffix);
    Count_Diff_cass_postdir := COUNT(GROUP,%Closest%.Diff_cass_postdir);
    Count_Diff_cass_unit_desig := COUNT(GROUP,%Closest%.Diff_cass_unit_desig);
    Count_Diff_cass_sec_range := COUNT(GROUP,%Closest%.Diff_cass_sec_range);
    Count_Diff_cass_p_city_name := COUNT(GROUP,%Closest%.Diff_cass_p_city_name);
    Count_Diff_cass_v_city_name := COUNT(GROUP,%Closest%.Diff_cass_v_city_name);
    Count_Diff_cass_st := COUNT(GROUP,%Closest%.Diff_cass_st);
    Count_Diff_cass_ace_zip := COUNT(GROUP,%Closest%.Diff_cass_ace_zip);
    Count_Diff_cass_zip4 := COUNT(GROUP,%Closest%.Diff_cass_zip4);
    Count_Diff_cass_cart := COUNT(GROUP,%Closest%.Diff_cass_cart);
    Count_Diff_cass_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cass_cr_sort_sz);
    Count_Diff_cass_lot := COUNT(GROUP,%Closest%.Diff_cass_lot);
    Count_Diff_cass_lot_order := COUNT(GROUP,%Closest%.Diff_cass_lot_order);
    Count_Diff_cass_dpbc := COUNT(GROUP,%Closest%.Diff_cass_dpbc);
    Count_Diff_cass_chk_digit := COUNT(GROUP,%Closest%.Diff_cass_chk_digit);
    Count_Diff_cass_record_type := COUNT(GROUP,%Closest%.Diff_cass_record_type);
    Count_Diff_cass_ace_fips_st := COUNT(GROUP,%Closest%.Diff_cass_ace_fips_st);
    Count_Diff_cass_fipscounty := COUNT(GROUP,%Closest%.Diff_cass_fipscounty);
    Count_Diff_cass_geo_lat := COUNT(GROUP,%Closest%.Diff_cass_geo_lat);
    Count_Diff_cass_geo_long := COUNT(GROUP,%Closest%.Diff_cass_geo_long);
    Count_Diff_cass_msa := COUNT(GROUP,%Closest%.Diff_cass_msa);
    Count_Diff_cass_geo_blk := COUNT(GROUP,%Closest%.Diff_cass_geo_blk);
    Count_Diff_cass_geo_match := COUNT(GROUP,%Closest%.Diff_cass_geo_match);
    Count_Diff_cass_err_stat := COUNT(GROUP,%Closest%.Diff_cass_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
