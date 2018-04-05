IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT party_Fields := MODULE
 
EXPORT NumFields := 82;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Batch','Non_Blank','Invalid_Num','Invalid_SSN','Invalid_Zip','Invalid_Money','Invalid_Char','Invalid_State');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Batch' => 1,'Non_Blank' => 2,'Invalid_Num' => 3,'Invalid_SSN' => 4,'Invalid_Zip' => 5,'Invalid_Money' => 6,'Invalid_Char' => 7,'Invalid_State' => 8,0);
 
EXPORT MakeFT_Invalid_Batch(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Batch(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Batch(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Non_Blank(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Non_Blank(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Non_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789-xX'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789-xX'))));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789-xX'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Zip(SALT38.StrType s) := WHICH(~Scrubs.fn_Valid_Zip(s)>0);
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_Valid_Zip'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Money(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Money(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_Invalid_Money(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789.'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT38.StrType s) := WHICH(~Scrubs.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_Valid_StateAbbrev'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','party_name','party_position','party_vocation','party_firm','inaddress','incity','instate','inzip','ssnumber','fines_levied','restitution','ok_for_fcr','party_text','title','fname','mname','lname','name_suffix','name_score','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','did','did_score','bdid','bdid_score','ssn_appended','dba_name','contact_name','enh_did_src');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'batch_number','incident_number','party_number','record_type','order_number','party_name','party_position','party_vocation','party_firm','inaddress','incity','instate','inzip','ssnumber','fines_levied','restitution','ok_for_fcr','party_text','title','fname','mname','lname','name_suffix','name_score','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','did','did_score','bdid','bdid_score','ssn_appended','dba_name','contact_name','enh_did_src');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'batch_number' => 0,'incident_number' => 1,'party_number' => 2,'record_type' => 3,'order_number' => 4,'party_name' => 5,'party_position' => 6,'party_vocation' => 7,'party_firm' => 8,'inaddress' => 9,'incity' => 10,'instate' => 11,'inzip' => 12,'ssnumber' => 13,'fines_levied' => 14,'restitution' => 15,'ok_for_fcr' => 16,'party_text' => 17,'title' => 18,'fname' => 19,'mname' => 20,'lname' => 21,'name_suffix' => 22,'name_score' => 23,'cname' => 24,'prim_range' => 25,'predir' => 26,'prim_name' => 27,'addr_suffix' => 28,'postdir' => 29,'unit_desig' => 30,'sec_range' => 31,'p_city_name' => 32,'v_city_name' => 33,'st' => 34,'zip5' => 35,'zip4' => 36,'fips_state' => 37,'fips_county' => 38,'addr_rec_type' => 39,'geo_lat' => 40,'geo_long' => 41,'cbsa' => 42,'geo_blk' => 43,'geo_match' => 44,'cart' => 45,'cr_sort_sz' => 46,'lot' => 47,'lot_order' => 48,'dpbc' => 49,'chk_digit' => 50,'err_stat' => 51,'dotid' => 52,'dotscore' => 53,'dotweight' => 54,'empid' => 55,'empscore' => 56,'empweight' => 57,'powid' => 58,'powscore' => 59,'powweight' => 60,'proxid' => 61,'proxscore' => 62,'proxweight' => 63,'seleid' => 64,'selescore' => 65,'seleweight' => 66,'orgid' => 67,'orgscore' => 68,'orgweight' => 69,'ultid' => 70,'ultscore' => 71,'ultweight' => 72,'source_rec_id' => 73,'did' => 74,'did_score' => 75,'bdid' => 76,'bdid_score' => 77,'ssn_appended' => 78,'dba_name' => 79,'contact_name' => 80,'enh_did_src' => 81,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],[],['ALLOW'],['LENGTH'],[],[],[],[],[],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_batch_number(SALT38.StrType s0) := MakeFT_Invalid_Batch(s0);
EXPORT InValid_batch_number(SALT38.StrType s) := InValidFT_Invalid_Batch(s);
EXPORT InValidMessage_batch_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Batch(wh);
 
EXPORT Make_incident_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_incident_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_incident_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_party_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_party_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_party_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := s0;
EXPORT InValid_record_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_order_number(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_order_number(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_order_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_party_name(SALT38.StrType s0) := MakeFT_Non_Blank(s0);
EXPORT InValid_party_name(SALT38.StrType s) := InValidFT_Non_Blank(s);
EXPORT InValidMessage_party_name(UNSIGNED1 wh) := InValidMessageFT_Non_Blank(wh);
 
EXPORT Make_party_position(SALT38.StrType s0) := s0;
EXPORT InValid_party_position(SALT38.StrType s) := 0;
EXPORT InValidMessage_party_position(UNSIGNED1 wh) := '';
 
EXPORT Make_party_vocation(SALT38.StrType s0) := s0;
EXPORT InValid_party_vocation(SALT38.StrType s) := 0;
EXPORT InValidMessage_party_vocation(UNSIGNED1 wh) := '';
 
EXPORT Make_party_firm(SALT38.StrType s0) := s0;
EXPORT InValid_party_firm(SALT38.StrType s) := 0;
EXPORT InValidMessage_party_firm(UNSIGNED1 wh) := '';
 
EXPORT Make_inaddress(SALT38.StrType s0) := s0;
EXPORT InValid_inaddress(SALT38.StrType s) := 0;
EXPORT InValidMessage_inaddress(UNSIGNED1 wh) := '';
 
EXPORT Make_incity(SALT38.StrType s0) := s0;
EXPORT InValid_incity(SALT38.StrType s) := 0;
EXPORT InValidMessage_incity(UNSIGNED1 wh) := '';
 
EXPORT Make_instate(SALT38.StrType s0) := s0;
EXPORT InValid_instate(SALT38.StrType s) := 0;
EXPORT InValidMessage_instate(UNSIGNED1 wh) := '';
 
EXPORT Make_inzip(SALT38.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_inzip(SALT38.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_inzip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_ssnumber(SALT38.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_ssnumber(SALT38.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_ssnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_fines_levied(SALT38.StrType s0) := MakeFT_Invalid_Money(s0);
EXPORT InValid_fines_levied(SALT38.StrType s) := InValidFT_Invalid_Money(s);
EXPORT InValidMessage_fines_levied(UNSIGNED1 wh) := InValidMessageFT_Invalid_Money(wh);
 
EXPORT Make_restitution(SALT38.StrType s0) := MakeFT_Invalid_Money(s0);
EXPORT InValid_restitution(SALT38.StrType s) := InValidFT_Invalid_Money(s);
EXPORT InValidMessage_restitution(UNSIGNED1 wh) := InValidMessageFT_Invalid_Money(wh);
 
EXPORT Make_ok_for_fcr(SALT38.StrType s0) := s0;
EXPORT InValid_ok_for_fcr(SALT38.StrType s) := 0;
EXPORT InValidMessage_ok_for_fcr(UNSIGNED1 wh) := '';
 
EXPORT Make_party_text(SALT38.StrType s0) := s0;
EXPORT InValid_party_text(SALT38.StrType s) := 0;
EXPORT InValidMessage_party_text(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := s0;
EXPORT InValid_fname(SALT38.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT38.StrType s0) := s0;
EXPORT InValid_mname(SALT38.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT38.StrType s0) := s0;
EXPORT InValid_lname(SALT38.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT38.StrType s0) := s0;
EXPORT InValid_name_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_cname(SALT38.StrType s0) := s0;
EXPORT InValid_cname(SALT38.StrType s) := 0;
EXPORT InValidMessage_cname(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := s0;
EXPORT InValid_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := s0;
EXPORT InValid_prim_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := s0;
EXPORT InValid_postdir(SALT38.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT38.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip5(SALT38.StrType s0) := s0;
EXPORT InValid_zip5(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT38.StrType s0) := s0;
EXPORT InValid_zip4(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT38.StrType s0) := s0;
EXPORT InValid_fips_state(SALT38.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT38.StrType s0) := s0;
EXPORT InValid_fips_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_addr_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT38.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT38.StrType s0) := s0;
EXPORT InValid_geo_long(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa(SALT38.StrType s0) := s0;
EXPORT InValid_cbsa(SALT38.StrType s) := 0;
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := s0;
EXPORT InValid_geo_match(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT38.StrType s0) := s0;
EXPORT InValid_cart(SALT38.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT38.StrType s0) := s0;
EXPORT InValid_lot(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT38.StrType s0) := s0;
EXPORT InValid_lot_order(SALT38.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT38.StrType s0) := s0;
EXPORT InValid_dpbc(SALT38.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT38.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT38.StrType s0) := s0;
EXPORT InValid_err_stat(SALT38.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dotid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dotscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dotscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dotweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dotweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_empid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_empid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_empscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_empscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_empweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_empweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_powscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_powscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_powweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_powweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_proxscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_proxscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_proxweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_proxweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_selescore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_selescore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_seleweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_seleweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_orgscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_orgscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_orgweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_orgweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ultscore(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ultscore(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ultweight(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ultweight(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_did_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_bdid_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_bdid_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ssn_appended(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ssn_appended(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ssn_appended(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dba_name(SALT38.StrType s0) := s0;
EXPORT InValid_dba_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_dba_name(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_name(SALT38.StrType s0) := s0;
EXPORT InValid_contact_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_contact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_enh_did_src(SALT38.StrType s0) := s0;
EXPORT InValid_enh_did_src(SALT38.StrType s) := 0;
EXPORT InValidMessage_enh_did_src(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_SANCTNKeys;
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
    BOOLEAN Diff_batch_number;
    BOOLEAN Diff_incident_number;
    BOOLEAN Diff_party_number;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_order_number;
    BOOLEAN Diff_party_name;
    BOOLEAN Diff_party_position;
    BOOLEAN Diff_party_vocation;
    BOOLEAN Diff_party_firm;
    BOOLEAN Diff_inaddress;
    BOOLEAN Diff_incity;
    BOOLEAN Diff_instate;
    BOOLEAN Diff_inzip;
    BOOLEAN Diff_ssnumber;
    BOOLEAN Diff_fines_levied;
    BOOLEAN Diff_restitution;
    BOOLEAN Diff_ok_for_fcr;
    BOOLEAN Diff_party_text;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_cname;
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
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_addr_rec_type;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_err_stat;
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
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_ssn_appended;
    BOOLEAN Diff_dba_name;
    BOOLEAN Diff_contact_name;
    BOOLEAN Diff_enh_did_src;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_batch_number := le.batch_number <> ri.batch_number;
    SELF.Diff_incident_number := le.incident_number <> ri.incident_number;
    SELF.Diff_party_number := le.party_number <> ri.party_number;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_order_number := le.order_number <> ri.order_number;
    SELF.Diff_party_name := le.party_name <> ri.party_name;
    SELF.Diff_party_position := le.party_position <> ri.party_position;
    SELF.Diff_party_vocation := le.party_vocation <> ri.party_vocation;
    SELF.Diff_party_firm := le.party_firm <> ri.party_firm;
    SELF.Diff_inaddress := le.inaddress <> ri.inaddress;
    SELF.Diff_incity := le.incity <> ri.incity;
    SELF.Diff_instate := le.instate <> ri.instate;
    SELF.Diff_inzip := le.inzip <> ri.inzip;
    SELF.Diff_ssnumber := le.ssnumber <> ri.ssnumber;
    SELF.Diff_fines_levied := le.fines_levied <> ri.fines_levied;
    SELF.Diff_restitution := le.restitution <> ri.restitution;
    SELF.Diff_ok_for_fcr := le.ok_for_fcr <> ri.ok_for_fcr;
    SELF.Diff_party_text := le.party_text <> ri.party_text;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_cname := le.cname <> ri.cname;
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
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_addr_rec_type := le.addr_rec_type <> ri.addr_rec_type;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
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
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_ssn_appended := le.ssn_appended <> ri.ssn_appended;
    SELF.Diff_dba_name := le.dba_name <> ri.dba_name;
    SELF.Diff_contact_name := le.contact_name <> ri.contact_name;
    SELF.Diff_enh_did_src := le.enh_did_src <> ri.enh_did_src;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_batch_number,1,0)+ IF( SELF.Diff_incident_number,1,0)+ IF( SELF.Diff_party_number,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_order_number,1,0)+ IF( SELF.Diff_party_name,1,0)+ IF( SELF.Diff_party_position,1,0)+ IF( SELF.Diff_party_vocation,1,0)+ IF( SELF.Diff_party_firm,1,0)+ IF( SELF.Diff_inaddress,1,0)+ IF( SELF.Diff_incity,1,0)+ IF( SELF.Diff_instate,1,0)+ IF( SELF.Diff_inzip,1,0)+ IF( SELF.Diff_ssnumber,1,0)+ IF( SELF.Diff_fines_levied,1,0)+ IF( SELF.Diff_restitution,1,0)+ IF( SELF.Diff_ok_for_fcr,1,0)+ IF( SELF.Diff_party_text,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_addr_rec_type,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_ssn_appended,1,0)+ IF( SELF.Diff_dba_name,1,0)+ IF( SELF.Diff_contact_name,1,0)+ IF( SELF.Diff_enh_did_src,1,0);
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
    Count_Diff_batch_number := COUNT(GROUP,%Closest%.Diff_batch_number);
    Count_Diff_incident_number := COUNT(GROUP,%Closest%.Diff_incident_number);
    Count_Diff_party_number := COUNT(GROUP,%Closest%.Diff_party_number);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_order_number := COUNT(GROUP,%Closest%.Diff_order_number);
    Count_Diff_party_name := COUNT(GROUP,%Closest%.Diff_party_name);
    Count_Diff_party_position := COUNT(GROUP,%Closest%.Diff_party_position);
    Count_Diff_party_vocation := COUNT(GROUP,%Closest%.Diff_party_vocation);
    Count_Diff_party_firm := COUNT(GROUP,%Closest%.Diff_party_firm);
    Count_Diff_inaddress := COUNT(GROUP,%Closest%.Diff_inaddress);
    Count_Diff_incity := COUNT(GROUP,%Closest%.Diff_incity);
    Count_Diff_instate := COUNT(GROUP,%Closest%.Diff_instate);
    Count_Diff_inzip := COUNT(GROUP,%Closest%.Diff_inzip);
    Count_Diff_ssnumber := COUNT(GROUP,%Closest%.Diff_ssnumber);
    Count_Diff_fines_levied := COUNT(GROUP,%Closest%.Diff_fines_levied);
    Count_Diff_restitution := COUNT(GROUP,%Closest%.Diff_restitution);
    Count_Diff_ok_for_fcr := COUNT(GROUP,%Closest%.Diff_ok_for_fcr);
    Count_Diff_party_text := COUNT(GROUP,%Closest%.Diff_party_text);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
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
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_addr_rec_type := COUNT(GROUP,%Closest%.Diff_addr_rec_type);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
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
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_ssn_appended := COUNT(GROUP,%Closest%.Diff_ssn_appended);
    Count_Diff_dba_name := COUNT(GROUP,%Closest%.Diff_dba_name);
    Count_Diff_contact_name := COUNT(GROUP,%Closest%.Diff_contact_name);
    Count_Diff_enh_did_src := COUNT(GROUP,%Closest%.Diff_enh_did_src);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
