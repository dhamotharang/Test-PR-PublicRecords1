IMPORT SALT311;
EXPORT Contacts_Fields := MODULE
 
EXPORT NumFields := 94;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Date','Invalid_AlphaCaps','Invalid_AlphaNum','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Date' => 3,'Invalid_AlphaCaps' => 4,'Invalid_AlphaNum' => 5,'Invalid_Alpha' => 6,'Invalid_AlphaChar' => 7,'Invalid_AlphaNumChar' => 8,'Invalid_State' => 9,'Invalid_Zip' => 10,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/()'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaCaps(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaCaps(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaCaps(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.,'))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.,'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@&/`\'()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@&/`\'()'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@&/`\'()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@#&/`\'()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@#&/`\'()'))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@#&/`\'()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_AlphaCaps(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-/()'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-/()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-/()'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincontactid','rawfields_maincompanyid','rawfields_active','rawfields_firstname','rawfields_midinital','rawfields_lastname','rawfields_age','rawfields_gender','rawfields_primarytitle','rawfields_titlelevel1','rawfields_primarydept','rawfields_secondtitle','rawfields_titlelevel2','rawfields_seconddept','rawfields_thirdtitle','rawfields_titlelevel3','rawfields_thirddept','rawfields_skillcategory','rawfields_skillsubcategory','rawfields_reportto','rawfields_officephone','rawfields_officeext','rawfields_officefax','rawfields_officeemail','rawfields_directdial','rawfields_mobilephone','rawfields_officeaddress1','rawfields_officeaddress2','rawfields_officecity','rawfields_officestate','rawfields_officezip','rawfields_officecountry','rawfields_school','rawfields_degree','rawfields_graduationyear','rawfields_country','rawfields_salary','rawfields_bonus','rawfields_compensation','rawfields_citizenship','rawfields_diversitycandidate','rawfields_entrydate','rawfields_lastupdate','clean_contact_name_title','clean_contact_name_fname','clean_contact_name_mname','clean_contact_name_lname','clean_contact_name_name_suffix','clean_contact_name_name_score','clean_contact_address_prim_range','clean_contact_address_predir','clean_contact_address_prim_name','clean_contact_address_addr_suffix','clean_contact_address_postdir','clean_contact_address_unit_desig','clean_contact_address_sec_range','clean_contact_address_p_city_name','clean_contact_address_v_city_name','clean_contact_address_st','clean_contact_address_zip','clean_contact_address_zip4','clean_contact_address_cart','clean_contact_address_cr_sort_sz','clean_contact_address_lot','clean_contact_address_lot_order','clean_contact_address_dbpc','clean_contact_address_chk_digit','clean_contact_address_rec_type','clean_contact_address_fips_state','clean_contact_address_fips_county','clean_contact_address_geo_lat','clean_contact_address_geo_long','clean_contact_address_msa','clean_contact_address_geo_blk','clean_contact_address_geo_match','clean_contact_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_officephone','clean_phones_directdial','clean_phones_mobilephone','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','raw_aid','ace_aid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincontactid','rawfields_maincompanyid','rawfields_active','rawfields_firstname','rawfields_midinital','rawfields_lastname','rawfields_age','rawfields_gender','rawfields_primarytitle','rawfields_titlelevel1','rawfields_primarydept','rawfields_secondtitle','rawfields_titlelevel2','rawfields_seconddept','rawfields_thirdtitle','rawfields_titlelevel3','rawfields_thirddept','rawfields_skillcategory','rawfields_skillsubcategory','rawfields_reportto','rawfields_officephone','rawfields_officeext','rawfields_officefax','rawfields_officeemail','rawfields_directdial','rawfields_mobilephone','rawfields_officeaddress1','rawfields_officeaddress2','rawfields_officecity','rawfields_officestate','rawfields_officezip','rawfields_officecountry','rawfields_school','rawfields_degree','rawfields_graduationyear','rawfields_country','rawfields_salary','rawfields_bonus','rawfields_compensation','rawfields_citizenship','rawfields_diversitycandidate','rawfields_entrydate','rawfields_lastupdate','clean_contact_name_title','clean_contact_name_fname','clean_contact_name_mname','clean_contact_name_lname','clean_contact_name_name_suffix','clean_contact_name_name_score','clean_contact_address_prim_range','clean_contact_address_predir','clean_contact_address_prim_name','clean_contact_address_addr_suffix','clean_contact_address_postdir','clean_contact_address_unit_desig','clean_contact_address_sec_range','clean_contact_address_p_city_name','clean_contact_address_v_city_name','clean_contact_address_st','clean_contact_address_zip','clean_contact_address_zip4','clean_contact_address_cart','clean_contact_address_cr_sort_sz','clean_contact_address_lot','clean_contact_address_lot_order','clean_contact_address_dbpc','clean_contact_address_chk_digit','clean_contact_address_rec_type','clean_contact_address_fips_state','clean_contact_address_fips_county','clean_contact_address_geo_lat','clean_contact_address_geo_long','clean_contact_address_msa','clean_contact_address_geo_blk','clean_contact_address_geo_match','clean_contact_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_officephone','clean_phones_directdial','clean_phones_mobilephone','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'did' => 0,'did_score' => 1,'bdid' => 2,'bdid_score' => 3,'raw_aid' => 4,'ace_aid' => 5,'dt_first_seen' => 6,'dt_last_seen' => 7,'dt_vendor_first_reported' => 8,'dt_vendor_last_reported' => 9,'record_type' => 10,'rawfields_maincontactid' => 11,'rawfields_maincompanyid' => 12,'rawfields_active' => 13,'rawfields_firstname' => 14,'rawfields_midinital' => 15,'rawfields_lastname' => 16,'rawfields_age' => 17,'rawfields_gender' => 18,'rawfields_primarytitle' => 19,'rawfields_titlelevel1' => 20,'rawfields_primarydept' => 21,'rawfields_secondtitle' => 22,'rawfields_titlelevel2' => 23,'rawfields_seconddept' => 24,'rawfields_thirdtitle' => 25,'rawfields_titlelevel3' => 26,'rawfields_thirddept' => 27,'rawfields_skillcategory' => 28,'rawfields_skillsubcategory' => 29,'rawfields_reportto' => 30,'rawfields_officephone' => 31,'rawfields_officeext' => 32,'rawfields_officefax' => 33,'rawfields_officeemail' => 34,'rawfields_directdial' => 35,'rawfields_mobilephone' => 36,'rawfields_officeaddress1' => 37,'rawfields_officeaddress2' => 38,'rawfields_officecity' => 39,'rawfields_officestate' => 40,'rawfields_officezip' => 41,'rawfields_officecountry' => 42,'rawfields_school' => 43,'rawfields_degree' => 44,'rawfields_graduationyear' => 45,'rawfields_country' => 46,'rawfields_salary' => 47,'rawfields_bonus' => 48,'rawfields_compensation' => 49,'rawfields_citizenship' => 50,'rawfields_diversitycandidate' => 51,'rawfields_entrydate' => 52,'rawfields_lastupdate' => 53,'clean_contact_name_title' => 54,'clean_contact_name_fname' => 55,'clean_contact_name_mname' => 56,'clean_contact_name_lname' => 57,'clean_contact_name_name_suffix' => 58,'clean_contact_name_name_score' => 59,'clean_contact_address_prim_range' => 60,'clean_contact_address_predir' => 61,'clean_contact_address_prim_name' => 62,'clean_contact_address_addr_suffix' => 63,'clean_contact_address_postdir' => 64,'clean_contact_address_unit_desig' => 65,'clean_contact_address_sec_range' => 66,'clean_contact_address_p_city_name' => 67,'clean_contact_address_v_city_name' => 68,'clean_contact_address_st' => 69,'clean_contact_address_zip' => 70,'clean_contact_address_zip4' => 71,'clean_contact_address_cart' => 72,'clean_contact_address_cr_sort_sz' => 73,'clean_contact_address_lot' => 74,'clean_contact_address_lot_order' => 75,'clean_contact_address_dbpc' => 76,'clean_contact_address_chk_digit' => 77,'clean_contact_address_rec_type' => 78,'clean_contact_address_fips_state' => 79,'clean_contact_address_fips_county' => 80,'clean_contact_address_geo_lat' => 81,'clean_contact_address_geo_long' => 82,'clean_contact_address_msa' => 83,'clean_contact_address_geo_blk' => 84,'clean_contact_address_geo_match' => 85,'clean_contact_address_err_stat' => 86,'clean_dates_entrydate' => 87,'clean_dates_lastupdate' => 88,'clean_phones_officephone' => 89,'clean_phones_directdial' => 90,'clean_phones_mobilephone' => 91,'global_sid' => 92,'record_sid' => 93,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT311.StrType s0) := s0;
EXPORT InValid_did_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid_score(SALT311.StrType s0) := s0;
EXPORT InValid_bdid_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT311.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT311.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_maincontactid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_maincontactid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_maincontactid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_maincompanyid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_maincompanyid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_maincompanyid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_active(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_active(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_active(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_firstname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_firstname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_firstname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_midinital(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_midinital(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_midinital(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_lastname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_lastname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_lastname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_age(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_age(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_age(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_gender(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_gender(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_primarytitle(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_primarytitle(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_primarytitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_titlelevel1(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_titlelevel1(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_titlelevel1(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_primarydept(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_primarydept(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_primarydept(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_secondtitle(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_secondtitle(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_secondtitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_titlelevel2(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_titlelevel2(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_titlelevel2(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_seconddept(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_seconddept(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_seconddept(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_thirdtitle(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_thirdtitle(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_thirdtitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_titlelevel3(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_titlelevel3(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_titlelevel3(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_thirddept(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_thirddept(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_thirddept(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_skillcategory(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_skillcategory(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_skillcategory(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_skillsubcategory(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_skillsubcategory(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_skillsubcategory(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_reportto(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_reportto(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_reportto(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_officephone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_officephone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_officephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_officeext(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_officeext(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_officeext(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_officefax(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_officefax(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_officefax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_officeemail(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_rawfields_officeemail(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_rawfields_officeemail(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_rawfields_directdial(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_directdial(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_directdial(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_mobilephone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_mobilephone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_mobilephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_officeaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_rawfields_officeaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_rawfields_officeaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_rawfields_officeaddress2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_rawfields_officeaddress2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_rawfields_officeaddress2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_rawfields_officecity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_officecity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_officecity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_officestate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_rawfields_officestate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_rawfields_officestate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_rawfields_officezip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_rawfields_officezip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_rawfields_officezip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_rawfields_officecountry(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_officecountry(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_officecountry(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_school(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_school(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_school(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_degree(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_degree(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_degree(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_graduationyear(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_graduationyear(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_graduationyear(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_country(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_country(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_salary(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_salary(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_salary(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_bonus(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_bonus(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_bonus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_compensation(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_compensation(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_compensation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_citizenship(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_rawfields_citizenship(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_rawfields_citizenship(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_rawfields_diversitycandidate(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_diversitycandidate(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_diversitycandidate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_entrydate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_rawfields_entrydate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_rawfields_entrydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_rawfields_lastupdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_rawfields_lastupdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_rawfields_lastupdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_clean_contact_name_title(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_name_title(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_name_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_name_fname(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_name_fname(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_name_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_name_mname(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_name_mname(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_name_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_name_lname(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_name_lname(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_name_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_name_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_name_name_suffix(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_name_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_name_name_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_name_name_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_name_name_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_prim_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_prim_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_predir(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_predir(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_prim_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_contact_address_prim_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_contact_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_contact_address_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_postdir(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_postdir(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_unit_desig(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_sec_range(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_sec_range(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_p_city_name(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_v_city_name(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_clean_contact_address_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_clean_contact_address_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_clean_contact_address_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_clean_contact_address_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_clean_contact_address_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_clean_contact_address_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_contact_address_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_contact_address_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_contact_address_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_lot_order(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_lot_order(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_dbpc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_dbpc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_rec_type(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_clean_contact_address_rec_type(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_clean_contact_address_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_clean_contact_address_fips_state(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_fips_state(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_fips_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_fips_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_fips_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_contact_address_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_contact_address_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_contact_address_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_contact_address_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_contact_address_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_contact_address_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_geo_blk(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_contact_address_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_contact_address_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_contact_address_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_contact_address_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_contact_address_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_dates_entrydate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_clean_dates_entrydate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_clean_dates_entrydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_clean_dates_lastupdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_clean_dates_lastupdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_clean_dates_lastupdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_clean_phones_officephone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_phones_officephone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_phones_officephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_phones_directdial(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_phones_directdial(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_phones_directdial(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_phones_mobilephone(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_phones_mobilephone(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_phones_mobilephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_global_sid(SALT311.StrType s0) := s0;
EXPORT InValid_global_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT311.StrType s0) := s0;
EXPORT InValid_record_sid(SALT311.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Sheila_Greco;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_rawfields_maincontactid;
    BOOLEAN Diff_rawfields_maincompanyid;
    BOOLEAN Diff_rawfields_active;
    BOOLEAN Diff_rawfields_firstname;
    BOOLEAN Diff_rawfields_midinital;
    BOOLEAN Diff_rawfields_lastname;
    BOOLEAN Diff_rawfields_age;
    BOOLEAN Diff_rawfields_gender;
    BOOLEAN Diff_rawfields_primarytitle;
    BOOLEAN Diff_rawfields_titlelevel1;
    BOOLEAN Diff_rawfields_primarydept;
    BOOLEAN Diff_rawfields_secondtitle;
    BOOLEAN Diff_rawfields_titlelevel2;
    BOOLEAN Diff_rawfields_seconddept;
    BOOLEAN Diff_rawfields_thirdtitle;
    BOOLEAN Diff_rawfields_titlelevel3;
    BOOLEAN Diff_rawfields_thirddept;
    BOOLEAN Diff_rawfields_skillcategory;
    BOOLEAN Diff_rawfields_skillsubcategory;
    BOOLEAN Diff_rawfields_reportto;
    BOOLEAN Diff_rawfields_officephone;
    BOOLEAN Diff_rawfields_officeext;
    BOOLEAN Diff_rawfields_officefax;
    BOOLEAN Diff_rawfields_officeemail;
    BOOLEAN Diff_rawfields_directdial;
    BOOLEAN Diff_rawfields_mobilephone;
    BOOLEAN Diff_rawfields_officeaddress1;
    BOOLEAN Diff_rawfields_officeaddress2;
    BOOLEAN Diff_rawfields_officecity;
    BOOLEAN Diff_rawfields_officestate;
    BOOLEAN Diff_rawfields_officezip;
    BOOLEAN Diff_rawfields_officecountry;
    BOOLEAN Diff_rawfields_school;
    BOOLEAN Diff_rawfields_degree;
    BOOLEAN Diff_rawfields_graduationyear;
    BOOLEAN Diff_rawfields_country;
    BOOLEAN Diff_rawfields_salary;
    BOOLEAN Diff_rawfields_bonus;
    BOOLEAN Diff_rawfields_compensation;
    BOOLEAN Diff_rawfields_citizenship;
    BOOLEAN Diff_rawfields_diversitycandidate;
    BOOLEAN Diff_rawfields_entrydate;
    BOOLEAN Diff_rawfields_lastupdate;
    BOOLEAN Diff_clean_contact_name_title;
    BOOLEAN Diff_clean_contact_name_fname;
    BOOLEAN Diff_clean_contact_name_mname;
    BOOLEAN Diff_clean_contact_name_lname;
    BOOLEAN Diff_clean_contact_name_name_suffix;
    BOOLEAN Diff_clean_contact_name_name_score;
    BOOLEAN Diff_clean_contact_address_prim_range;
    BOOLEAN Diff_clean_contact_address_predir;
    BOOLEAN Diff_clean_contact_address_prim_name;
    BOOLEAN Diff_clean_contact_address_addr_suffix;
    BOOLEAN Diff_clean_contact_address_postdir;
    BOOLEAN Diff_clean_contact_address_unit_desig;
    BOOLEAN Diff_clean_contact_address_sec_range;
    BOOLEAN Diff_clean_contact_address_p_city_name;
    BOOLEAN Diff_clean_contact_address_v_city_name;
    BOOLEAN Diff_clean_contact_address_st;
    BOOLEAN Diff_clean_contact_address_zip;
    BOOLEAN Diff_clean_contact_address_zip4;
    BOOLEAN Diff_clean_contact_address_cart;
    BOOLEAN Diff_clean_contact_address_cr_sort_sz;
    BOOLEAN Diff_clean_contact_address_lot;
    BOOLEAN Diff_clean_contact_address_lot_order;
    BOOLEAN Diff_clean_contact_address_dbpc;
    BOOLEAN Diff_clean_contact_address_chk_digit;
    BOOLEAN Diff_clean_contact_address_rec_type;
    BOOLEAN Diff_clean_contact_address_fips_state;
    BOOLEAN Diff_clean_contact_address_fips_county;
    BOOLEAN Diff_clean_contact_address_geo_lat;
    BOOLEAN Diff_clean_contact_address_geo_long;
    BOOLEAN Diff_clean_contact_address_msa;
    BOOLEAN Diff_clean_contact_address_geo_blk;
    BOOLEAN Diff_clean_contact_address_geo_match;
    BOOLEAN Diff_clean_contact_address_err_stat;
    BOOLEAN Diff_clean_dates_entrydate;
    BOOLEAN Diff_clean_dates_lastupdate;
    BOOLEAN Diff_clean_phones_officephone;
    BOOLEAN Diff_clean_phones_directdial;
    BOOLEAN Diff_clean_phones_mobilephone;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_rawfields_maincontactid := le.rawfields_maincontactid <> ri.rawfields_maincontactid;
    SELF.Diff_rawfields_maincompanyid := le.rawfields_maincompanyid <> ri.rawfields_maincompanyid;
    SELF.Diff_rawfields_active := le.rawfields_active <> ri.rawfields_active;
    SELF.Diff_rawfields_firstname := le.rawfields_firstname <> ri.rawfields_firstname;
    SELF.Diff_rawfields_midinital := le.rawfields_midinital <> ri.rawfields_midinital;
    SELF.Diff_rawfields_lastname := le.rawfields_lastname <> ri.rawfields_lastname;
    SELF.Diff_rawfields_age := le.rawfields_age <> ri.rawfields_age;
    SELF.Diff_rawfields_gender := le.rawfields_gender <> ri.rawfields_gender;
    SELF.Diff_rawfields_primarytitle := le.rawfields_primarytitle <> ri.rawfields_primarytitle;
    SELF.Diff_rawfields_titlelevel1 := le.rawfields_titlelevel1 <> ri.rawfields_titlelevel1;
    SELF.Diff_rawfields_primarydept := le.rawfields_primarydept <> ri.rawfields_primarydept;
    SELF.Diff_rawfields_secondtitle := le.rawfields_secondtitle <> ri.rawfields_secondtitle;
    SELF.Diff_rawfields_titlelevel2 := le.rawfields_titlelevel2 <> ri.rawfields_titlelevel2;
    SELF.Diff_rawfields_seconddept := le.rawfields_seconddept <> ri.rawfields_seconddept;
    SELF.Diff_rawfields_thirdtitle := le.rawfields_thirdtitle <> ri.rawfields_thirdtitle;
    SELF.Diff_rawfields_titlelevel3 := le.rawfields_titlelevel3 <> ri.rawfields_titlelevel3;
    SELF.Diff_rawfields_thirddept := le.rawfields_thirddept <> ri.rawfields_thirddept;
    SELF.Diff_rawfields_skillcategory := le.rawfields_skillcategory <> ri.rawfields_skillcategory;
    SELF.Diff_rawfields_skillsubcategory := le.rawfields_skillsubcategory <> ri.rawfields_skillsubcategory;
    SELF.Diff_rawfields_reportto := le.rawfields_reportto <> ri.rawfields_reportto;
    SELF.Diff_rawfields_officephone := le.rawfields_officephone <> ri.rawfields_officephone;
    SELF.Diff_rawfields_officeext := le.rawfields_officeext <> ri.rawfields_officeext;
    SELF.Diff_rawfields_officefax := le.rawfields_officefax <> ri.rawfields_officefax;
    SELF.Diff_rawfields_officeemail := le.rawfields_officeemail <> ri.rawfields_officeemail;
    SELF.Diff_rawfields_directdial := le.rawfields_directdial <> ri.rawfields_directdial;
    SELF.Diff_rawfields_mobilephone := le.rawfields_mobilephone <> ri.rawfields_mobilephone;
    SELF.Diff_rawfields_officeaddress1 := le.rawfields_officeaddress1 <> ri.rawfields_officeaddress1;
    SELF.Diff_rawfields_officeaddress2 := le.rawfields_officeaddress2 <> ri.rawfields_officeaddress2;
    SELF.Diff_rawfields_officecity := le.rawfields_officecity <> ri.rawfields_officecity;
    SELF.Diff_rawfields_officestate := le.rawfields_officestate <> ri.rawfields_officestate;
    SELF.Diff_rawfields_officezip := le.rawfields_officezip <> ri.rawfields_officezip;
    SELF.Diff_rawfields_officecountry := le.rawfields_officecountry <> ri.rawfields_officecountry;
    SELF.Diff_rawfields_school := le.rawfields_school <> ri.rawfields_school;
    SELF.Diff_rawfields_degree := le.rawfields_degree <> ri.rawfields_degree;
    SELF.Diff_rawfields_graduationyear := le.rawfields_graduationyear <> ri.rawfields_graduationyear;
    SELF.Diff_rawfields_country := le.rawfields_country <> ri.rawfields_country;
    SELF.Diff_rawfields_salary := le.rawfields_salary <> ri.rawfields_salary;
    SELF.Diff_rawfields_bonus := le.rawfields_bonus <> ri.rawfields_bonus;
    SELF.Diff_rawfields_compensation := le.rawfields_compensation <> ri.rawfields_compensation;
    SELF.Diff_rawfields_citizenship := le.rawfields_citizenship <> ri.rawfields_citizenship;
    SELF.Diff_rawfields_diversitycandidate := le.rawfields_diversitycandidate <> ri.rawfields_diversitycandidate;
    SELF.Diff_rawfields_entrydate := le.rawfields_entrydate <> ri.rawfields_entrydate;
    SELF.Diff_rawfields_lastupdate := le.rawfields_lastupdate <> ri.rawfields_lastupdate;
    SELF.Diff_clean_contact_name_title := le.clean_contact_name_title <> ri.clean_contact_name_title;
    SELF.Diff_clean_contact_name_fname := le.clean_contact_name_fname <> ri.clean_contact_name_fname;
    SELF.Diff_clean_contact_name_mname := le.clean_contact_name_mname <> ri.clean_contact_name_mname;
    SELF.Diff_clean_contact_name_lname := le.clean_contact_name_lname <> ri.clean_contact_name_lname;
    SELF.Diff_clean_contact_name_name_suffix := le.clean_contact_name_name_suffix <> ri.clean_contact_name_name_suffix;
    SELF.Diff_clean_contact_name_name_score := le.clean_contact_name_name_score <> ri.clean_contact_name_name_score;
    SELF.Diff_clean_contact_address_prim_range := le.clean_contact_address_prim_range <> ri.clean_contact_address_prim_range;
    SELF.Diff_clean_contact_address_predir := le.clean_contact_address_predir <> ri.clean_contact_address_predir;
    SELF.Diff_clean_contact_address_prim_name := le.clean_contact_address_prim_name <> ri.clean_contact_address_prim_name;
    SELF.Diff_clean_contact_address_addr_suffix := le.clean_contact_address_addr_suffix <> ri.clean_contact_address_addr_suffix;
    SELF.Diff_clean_contact_address_postdir := le.clean_contact_address_postdir <> ri.clean_contact_address_postdir;
    SELF.Diff_clean_contact_address_unit_desig := le.clean_contact_address_unit_desig <> ri.clean_contact_address_unit_desig;
    SELF.Diff_clean_contact_address_sec_range := le.clean_contact_address_sec_range <> ri.clean_contact_address_sec_range;
    SELF.Diff_clean_contact_address_p_city_name := le.clean_contact_address_p_city_name <> ri.clean_contact_address_p_city_name;
    SELF.Diff_clean_contact_address_v_city_name := le.clean_contact_address_v_city_name <> ri.clean_contact_address_v_city_name;
    SELF.Diff_clean_contact_address_st := le.clean_contact_address_st <> ri.clean_contact_address_st;
    SELF.Diff_clean_contact_address_zip := le.clean_contact_address_zip <> ri.clean_contact_address_zip;
    SELF.Diff_clean_contact_address_zip4 := le.clean_contact_address_zip4 <> ri.clean_contact_address_zip4;
    SELF.Diff_clean_contact_address_cart := le.clean_contact_address_cart <> ri.clean_contact_address_cart;
    SELF.Diff_clean_contact_address_cr_sort_sz := le.clean_contact_address_cr_sort_sz <> ri.clean_contact_address_cr_sort_sz;
    SELF.Diff_clean_contact_address_lot := le.clean_contact_address_lot <> ri.clean_contact_address_lot;
    SELF.Diff_clean_contact_address_lot_order := le.clean_contact_address_lot_order <> ri.clean_contact_address_lot_order;
    SELF.Diff_clean_contact_address_dbpc := le.clean_contact_address_dbpc <> ri.clean_contact_address_dbpc;
    SELF.Diff_clean_contact_address_chk_digit := le.clean_contact_address_chk_digit <> ri.clean_contact_address_chk_digit;
    SELF.Diff_clean_contact_address_rec_type := le.clean_contact_address_rec_type <> ri.clean_contact_address_rec_type;
    SELF.Diff_clean_contact_address_fips_state := le.clean_contact_address_fips_state <> ri.clean_contact_address_fips_state;
    SELF.Diff_clean_contact_address_fips_county := le.clean_contact_address_fips_county <> ri.clean_contact_address_fips_county;
    SELF.Diff_clean_contact_address_geo_lat := le.clean_contact_address_geo_lat <> ri.clean_contact_address_geo_lat;
    SELF.Diff_clean_contact_address_geo_long := le.clean_contact_address_geo_long <> ri.clean_contact_address_geo_long;
    SELF.Diff_clean_contact_address_msa := le.clean_contact_address_msa <> ri.clean_contact_address_msa;
    SELF.Diff_clean_contact_address_geo_blk := le.clean_contact_address_geo_blk <> ri.clean_contact_address_geo_blk;
    SELF.Diff_clean_contact_address_geo_match := le.clean_contact_address_geo_match <> ri.clean_contact_address_geo_match;
    SELF.Diff_clean_contact_address_err_stat := le.clean_contact_address_err_stat <> ri.clean_contact_address_err_stat;
    SELF.Diff_clean_dates_entrydate := le.clean_dates_entrydate <> ri.clean_dates_entrydate;
    SELF.Diff_clean_dates_lastupdate := le.clean_dates_lastupdate <> ri.clean_dates_lastupdate;
    SELF.Diff_clean_phones_officephone := le.clean_phones_officephone <> ri.clean_phones_officephone;
    SELF.Diff_clean_phones_directdial := le.clean_phones_directdial <> ri.clean_phones_directdial;
    SELF.Diff_clean_phones_mobilephone := le.clean_phones_mobilephone <> ri.clean_phones_mobilephone;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_rawfields_maincontactid,1,0)+ IF( SELF.Diff_rawfields_maincompanyid,1,0)+ IF( SELF.Diff_rawfields_active,1,0)+ IF( SELF.Diff_rawfields_firstname,1,0)+ IF( SELF.Diff_rawfields_midinital,1,0)+ IF( SELF.Diff_rawfields_lastname,1,0)+ IF( SELF.Diff_rawfields_age,1,0)+ IF( SELF.Diff_rawfields_gender,1,0)+ IF( SELF.Diff_rawfields_primarytitle,1,0)+ IF( SELF.Diff_rawfields_titlelevel1,1,0)+ IF( SELF.Diff_rawfields_primarydept,1,0)+ IF( SELF.Diff_rawfields_secondtitle,1,0)+ IF( SELF.Diff_rawfields_titlelevel2,1,0)+ IF( SELF.Diff_rawfields_seconddept,1,0)+ IF( SELF.Diff_rawfields_thirdtitle,1,0)+ IF( SELF.Diff_rawfields_titlelevel3,1,0)+ IF( SELF.Diff_rawfields_thirddept,1,0)+ IF( SELF.Diff_rawfields_skillcategory,1,0)+ IF( SELF.Diff_rawfields_skillsubcategory,1,0)+ IF( SELF.Diff_rawfields_reportto,1,0)+ IF( SELF.Diff_rawfields_officephone,1,0)+ IF( SELF.Diff_rawfields_officeext,1,0)+ IF( SELF.Diff_rawfields_officefax,1,0)+ IF( SELF.Diff_rawfields_officeemail,1,0)+ IF( SELF.Diff_rawfields_directdial,1,0)+ IF( SELF.Diff_rawfields_mobilephone,1,0)+ IF( SELF.Diff_rawfields_officeaddress1,1,0)+ IF( SELF.Diff_rawfields_officeaddress2,1,0)+ IF( SELF.Diff_rawfields_officecity,1,0)+ IF( SELF.Diff_rawfields_officestate,1,0)+ IF( SELF.Diff_rawfields_officezip,1,0)+ IF( SELF.Diff_rawfields_officecountry,1,0)+ IF( SELF.Diff_rawfields_school,1,0)+ IF( SELF.Diff_rawfields_degree,1,0)+ IF( SELF.Diff_rawfields_graduationyear,1,0)+ IF( SELF.Diff_rawfields_country,1,0)+ IF( SELF.Diff_rawfields_salary,1,0)+ IF( SELF.Diff_rawfields_bonus,1,0)+ IF( SELF.Diff_rawfields_compensation,1,0)+ IF( SELF.Diff_rawfields_citizenship,1,0)+ IF( SELF.Diff_rawfields_diversitycandidate,1,0)+ IF( SELF.Diff_rawfields_entrydate,1,0)+ IF( SELF.Diff_rawfields_lastupdate,1,0)+ IF( SELF.Diff_clean_contact_name_title,1,0)+ IF( SELF.Diff_clean_contact_name_fname,1,0)+ IF( SELF.Diff_clean_contact_name_mname,1,0)+ IF( SELF.Diff_clean_contact_name_lname,1,0)+ IF( SELF.Diff_clean_contact_name_name_suffix,1,0)+ IF( SELF.Diff_clean_contact_name_name_score,1,0)+ IF( SELF.Diff_clean_contact_address_prim_range,1,0)+ IF( SELF.Diff_clean_contact_address_predir,1,0)+ IF( SELF.Diff_clean_contact_address_prim_name,1,0)+ IF( SELF.Diff_clean_contact_address_addr_suffix,1,0)+ IF( SELF.Diff_clean_contact_address_postdir,1,0)+ IF( SELF.Diff_clean_contact_address_unit_desig,1,0)+ IF( SELF.Diff_clean_contact_address_sec_range,1,0)+ IF( SELF.Diff_clean_contact_address_p_city_name,1,0)+ IF( SELF.Diff_clean_contact_address_v_city_name,1,0)+ IF( SELF.Diff_clean_contact_address_st,1,0)+ IF( SELF.Diff_clean_contact_address_zip,1,0)+ IF( SELF.Diff_clean_contact_address_zip4,1,0)+ IF( SELF.Diff_clean_contact_address_cart,1,0)+ IF( SELF.Diff_clean_contact_address_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_contact_address_lot,1,0)+ IF( SELF.Diff_clean_contact_address_lot_order,1,0)+ IF( SELF.Diff_clean_contact_address_dbpc,1,0)+ IF( SELF.Diff_clean_contact_address_chk_digit,1,0)+ IF( SELF.Diff_clean_contact_address_rec_type,1,0)+ IF( SELF.Diff_clean_contact_address_fips_state,1,0)+ IF( SELF.Diff_clean_contact_address_fips_county,1,0)+ IF( SELF.Diff_clean_contact_address_geo_lat,1,0)+ IF( SELF.Diff_clean_contact_address_geo_long,1,0)+ IF( SELF.Diff_clean_contact_address_msa,1,0)+ IF( SELF.Diff_clean_contact_address_geo_blk,1,0)+ IF( SELF.Diff_clean_contact_address_geo_match,1,0)+ IF( SELF.Diff_clean_contact_address_err_stat,1,0)+ IF( SELF.Diff_clean_dates_entrydate,1,0)+ IF( SELF.Diff_clean_dates_lastupdate,1,0)+ IF( SELF.Diff_clean_phones_officephone,1,0)+ IF( SELF.Diff_clean_phones_directdial,1,0)+ IF( SELF.Diff_clean_phones_mobilephone,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_rawfields_maincontactid := COUNT(GROUP,%Closest%.Diff_rawfields_maincontactid);
    Count_Diff_rawfields_maincompanyid := COUNT(GROUP,%Closest%.Diff_rawfields_maincompanyid);
    Count_Diff_rawfields_active := COUNT(GROUP,%Closest%.Diff_rawfields_active);
    Count_Diff_rawfields_firstname := COUNT(GROUP,%Closest%.Diff_rawfields_firstname);
    Count_Diff_rawfields_midinital := COUNT(GROUP,%Closest%.Diff_rawfields_midinital);
    Count_Diff_rawfields_lastname := COUNT(GROUP,%Closest%.Diff_rawfields_lastname);
    Count_Diff_rawfields_age := COUNT(GROUP,%Closest%.Diff_rawfields_age);
    Count_Diff_rawfields_gender := COUNT(GROUP,%Closest%.Diff_rawfields_gender);
    Count_Diff_rawfields_primarytitle := COUNT(GROUP,%Closest%.Diff_rawfields_primarytitle);
    Count_Diff_rawfields_titlelevel1 := COUNT(GROUP,%Closest%.Diff_rawfields_titlelevel1);
    Count_Diff_rawfields_primarydept := COUNT(GROUP,%Closest%.Diff_rawfields_primarydept);
    Count_Diff_rawfields_secondtitle := COUNT(GROUP,%Closest%.Diff_rawfields_secondtitle);
    Count_Diff_rawfields_titlelevel2 := COUNT(GROUP,%Closest%.Diff_rawfields_titlelevel2);
    Count_Diff_rawfields_seconddept := COUNT(GROUP,%Closest%.Diff_rawfields_seconddept);
    Count_Diff_rawfields_thirdtitle := COUNT(GROUP,%Closest%.Diff_rawfields_thirdtitle);
    Count_Diff_rawfields_titlelevel3 := COUNT(GROUP,%Closest%.Diff_rawfields_titlelevel3);
    Count_Diff_rawfields_thirddept := COUNT(GROUP,%Closest%.Diff_rawfields_thirddept);
    Count_Diff_rawfields_skillcategory := COUNT(GROUP,%Closest%.Diff_rawfields_skillcategory);
    Count_Diff_rawfields_skillsubcategory := COUNT(GROUP,%Closest%.Diff_rawfields_skillsubcategory);
    Count_Diff_rawfields_reportto := COUNT(GROUP,%Closest%.Diff_rawfields_reportto);
    Count_Diff_rawfields_officephone := COUNT(GROUP,%Closest%.Diff_rawfields_officephone);
    Count_Diff_rawfields_officeext := COUNT(GROUP,%Closest%.Diff_rawfields_officeext);
    Count_Diff_rawfields_officefax := COUNT(GROUP,%Closest%.Diff_rawfields_officefax);
    Count_Diff_rawfields_officeemail := COUNT(GROUP,%Closest%.Diff_rawfields_officeemail);
    Count_Diff_rawfields_directdial := COUNT(GROUP,%Closest%.Diff_rawfields_directdial);
    Count_Diff_rawfields_mobilephone := COUNT(GROUP,%Closest%.Diff_rawfields_mobilephone);
    Count_Diff_rawfields_officeaddress1 := COUNT(GROUP,%Closest%.Diff_rawfields_officeaddress1);
    Count_Diff_rawfields_officeaddress2 := COUNT(GROUP,%Closest%.Diff_rawfields_officeaddress2);
    Count_Diff_rawfields_officecity := COUNT(GROUP,%Closest%.Diff_rawfields_officecity);
    Count_Diff_rawfields_officestate := COUNT(GROUP,%Closest%.Diff_rawfields_officestate);
    Count_Diff_rawfields_officezip := COUNT(GROUP,%Closest%.Diff_rawfields_officezip);
    Count_Diff_rawfields_officecountry := COUNT(GROUP,%Closest%.Diff_rawfields_officecountry);
    Count_Diff_rawfields_school := COUNT(GROUP,%Closest%.Diff_rawfields_school);
    Count_Diff_rawfields_degree := COUNT(GROUP,%Closest%.Diff_rawfields_degree);
    Count_Diff_rawfields_graduationyear := COUNT(GROUP,%Closest%.Diff_rawfields_graduationyear);
    Count_Diff_rawfields_country := COUNT(GROUP,%Closest%.Diff_rawfields_country);
    Count_Diff_rawfields_salary := COUNT(GROUP,%Closest%.Diff_rawfields_salary);
    Count_Diff_rawfields_bonus := COUNT(GROUP,%Closest%.Diff_rawfields_bonus);
    Count_Diff_rawfields_compensation := COUNT(GROUP,%Closest%.Diff_rawfields_compensation);
    Count_Diff_rawfields_citizenship := COUNT(GROUP,%Closest%.Diff_rawfields_citizenship);
    Count_Diff_rawfields_diversitycandidate := COUNT(GROUP,%Closest%.Diff_rawfields_diversitycandidate);
    Count_Diff_rawfields_entrydate := COUNT(GROUP,%Closest%.Diff_rawfields_entrydate);
    Count_Diff_rawfields_lastupdate := COUNT(GROUP,%Closest%.Diff_rawfields_lastupdate);
    Count_Diff_clean_contact_name_title := COUNT(GROUP,%Closest%.Diff_clean_contact_name_title);
    Count_Diff_clean_contact_name_fname := COUNT(GROUP,%Closest%.Diff_clean_contact_name_fname);
    Count_Diff_clean_contact_name_mname := COUNT(GROUP,%Closest%.Diff_clean_contact_name_mname);
    Count_Diff_clean_contact_name_lname := COUNT(GROUP,%Closest%.Diff_clean_contact_name_lname);
    Count_Diff_clean_contact_name_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_contact_name_name_suffix);
    Count_Diff_clean_contact_name_name_score := COUNT(GROUP,%Closest%.Diff_clean_contact_name_name_score);
    Count_Diff_clean_contact_address_prim_range := COUNT(GROUP,%Closest%.Diff_clean_contact_address_prim_range);
    Count_Diff_clean_contact_address_predir := COUNT(GROUP,%Closest%.Diff_clean_contact_address_predir);
    Count_Diff_clean_contact_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_contact_address_prim_name);
    Count_Diff_clean_contact_address_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_contact_address_addr_suffix);
    Count_Diff_clean_contact_address_postdir := COUNT(GROUP,%Closest%.Diff_clean_contact_address_postdir);
    Count_Diff_clean_contact_address_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_contact_address_unit_desig);
    Count_Diff_clean_contact_address_sec_range := COUNT(GROUP,%Closest%.Diff_clean_contact_address_sec_range);
    Count_Diff_clean_contact_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_contact_address_p_city_name);
    Count_Diff_clean_contact_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_contact_address_v_city_name);
    Count_Diff_clean_contact_address_st := COUNT(GROUP,%Closest%.Diff_clean_contact_address_st);
    Count_Diff_clean_contact_address_zip := COUNT(GROUP,%Closest%.Diff_clean_contact_address_zip);
    Count_Diff_clean_contact_address_zip4 := COUNT(GROUP,%Closest%.Diff_clean_contact_address_zip4);
    Count_Diff_clean_contact_address_cart := COUNT(GROUP,%Closest%.Diff_clean_contact_address_cart);
    Count_Diff_clean_contact_address_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_contact_address_cr_sort_sz);
    Count_Diff_clean_contact_address_lot := COUNT(GROUP,%Closest%.Diff_clean_contact_address_lot);
    Count_Diff_clean_contact_address_lot_order := COUNT(GROUP,%Closest%.Diff_clean_contact_address_lot_order);
    Count_Diff_clean_contact_address_dbpc := COUNT(GROUP,%Closest%.Diff_clean_contact_address_dbpc);
    Count_Diff_clean_contact_address_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_contact_address_chk_digit);
    Count_Diff_clean_contact_address_rec_type := COUNT(GROUP,%Closest%.Diff_clean_contact_address_rec_type);
    Count_Diff_clean_contact_address_fips_state := COUNT(GROUP,%Closest%.Diff_clean_contact_address_fips_state);
    Count_Diff_clean_contact_address_fips_county := COUNT(GROUP,%Closest%.Diff_clean_contact_address_fips_county);
    Count_Diff_clean_contact_address_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_contact_address_geo_lat);
    Count_Diff_clean_contact_address_geo_long := COUNT(GROUP,%Closest%.Diff_clean_contact_address_geo_long);
    Count_Diff_clean_contact_address_msa := COUNT(GROUP,%Closest%.Diff_clean_contact_address_msa);
    Count_Diff_clean_contact_address_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_contact_address_geo_blk);
    Count_Diff_clean_contact_address_geo_match := COUNT(GROUP,%Closest%.Diff_clean_contact_address_geo_match);
    Count_Diff_clean_contact_address_err_stat := COUNT(GROUP,%Closest%.Diff_clean_contact_address_err_stat);
    Count_Diff_clean_dates_entrydate := COUNT(GROUP,%Closest%.Diff_clean_dates_entrydate);
    Count_Diff_clean_dates_lastupdate := COUNT(GROUP,%Closest%.Diff_clean_dates_lastupdate);
    Count_Diff_clean_phones_officephone := COUNT(GROUP,%Closest%.Diff_clean_phones_officephone);
    Count_Diff_clean_phones_directdial := COUNT(GROUP,%Closest%.Diff_clean_phones_directdial);
    Count_Diff_clean_phones_mobilephone := COUNT(GROUP,%Closest%.Diff_clean_phones_mobilephone);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
