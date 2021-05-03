IMPORT SALT311;
IMPORT Scrubs_SalesChannel,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 86;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_PrintableChar','Invalid_No','Invalid_Float','Invalid_Date','Invalid_Alpha','Invalid_AlphaChars','Invalid_AlphaNum','Invalid_State','Invalid_Zip');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_PrintableChar' => 1,'Invalid_No' => 2,'Invalid_Float' => 3,'Invalid_Date' => 4,'Invalid_Alpha' => 5,'Invalid_AlphaChars' => 6,'Invalid_AlphaNum' => 7,'Invalid_State' => 8,'Invalid_Zip' => 9,0);
 
EXPORT MakeFT_Invalid_PrintableChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_PrintableChar(SALT311.StrType s) := WHICH(~Scrubs_SalesChannel.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_PrintableChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SalesChannel.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-,/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-,/'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-,/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChars(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChars(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'))));
EXPORT InValidMessageFT_Invalid_AlphaChars(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\''),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .-,/'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .-,/'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .-,/'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'rid','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rawaid','aceaid','record_type','rawfields_row_id','rawfields_company_name','rawfields_web_address','rawfields_prefix','rawfields_contact_name','rawfields_first_name','rawfields_middle_name','rawfields_last_name','rawfields_title','rawfields_address','rawfields_address1','rawfields_city','rawfields_state','rawfields_zip_code','rawfields_country','rawfields_phone_number','rawfields_email','clean_name_title','clean_name_fname','clean_name_mname','clean_name_lname','clean_name_name_suffix','clean_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','global_sid','record_sid','current_rec');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'rid','bdid','bdid_score','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','rawaid','aceaid','record_type','rawfields_row_id','rawfields_company_name','rawfields_web_address','rawfields_prefix','rawfields_contact_name','rawfields_first_name','rawfields_middle_name','rawfields_last_name','rawfields_title','rawfields_address','rawfields_address1','rawfields_city','rawfields_state','rawfields_zip_code','rawfields_country','rawfields_phone_number','rawfields_email','clean_name_title','clean_name_fname','clean_name_mname','clean_name_lname','clean_name_name_suffix','clean_name_name_score','clean_address_prim_range','clean_address_predir','clean_address_prim_name','clean_address_addr_suffix','clean_address_postdir','clean_address_unit_desig','clean_address_sec_range','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip','clean_address_zip4','clean_address_cart','clean_address_cr_sort_sz','clean_address_lot','clean_address_lot_order','clean_address_dbpc','clean_address_chk_digit','clean_address_rec_type','clean_address_fips_state','clean_address_fips_county','clean_address_geo_lat','clean_address_geo_long','clean_address_msa','clean_address_geo_blk','clean_address_geo_match','clean_address_err_stat','global_sid','record_sid','current_rec');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'rid' => 0,'bdid' => 1,'bdid_score' => 2,'dotid' => 3,'dotscore' => 4,'dotweight' => 5,'empid' => 6,'empscore' => 7,'empweight' => 8,'powid' => 9,'powscore' => 10,'powweight' => 11,'proxid' => 12,'proxscore' => 13,'proxweight' => 14,'seleid' => 15,'selescore' => 16,'seleweight' => 17,'orgid' => 18,'orgscore' => 19,'orgweight' => 20,'ultid' => 21,'ultscore' => 22,'ultweight' => 23,'did' => 24,'did_score' => 25,'date_first_seen' => 26,'date_last_seen' => 27,'date_vendor_first_reported' => 28,'date_vendor_last_reported' => 29,'rawaid' => 30,'aceaid' => 31,'record_type' => 32,'rawfields_row_id' => 33,'rawfields_company_name' => 34,'rawfields_web_address' => 35,'rawfields_prefix' => 36,'rawfields_contact_name' => 37,'rawfields_first_name' => 38,'rawfields_middle_name' => 39,'rawfields_last_name' => 40,'rawfields_title' => 41,'rawfields_address' => 42,'rawfields_address1' => 43,'rawfields_city' => 44,'rawfields_state' => 45,'rawfields_zip_code' => 46,'rawfields_country' => 47,'rawfields_phone_number' => 48,'rawfields_email' => 49,'clean_name_title' => 50,'clean_name_fname' => 51,'clean_name_mname' => 52,'clean_name_lname' => 53,'clean_name_name_suffix' => 54,'clean_name_name_score' => 55,'clean_address_prim_range' => 56,'clean_address_predir' => 57,'clean_address_prim_name' => 58,'clean_address_addr_suffix' => 59,'clean_address_postdir' => 60,'clean_address_unit_desig' => 61,'clean_address_sec_range' => 62,'clean_address_p_city_name' => 63,'clean_address_v_city_name' => 64,'clean_address_st' => 65,'clean_address_zip' => 66,'clean_address_zip4' => 67,'clean_address_cart' => 68,'clean_address_cr_sort_sz' => 69,'clean_address_lot' => 70,'clean_address_lot_order' => 71,'clean_address_dbpc' => 72,'clean_address_chk_digit' => 73,'clean_address_rec_type' => 74,'clean_address_fips_state' => 75,'clean_address_fips_county' => 76,'clean_address_geo_lat' => 77,'clean_address_geo_long' => 78,'clean_address_msa' => 79,'clean_address_geo_blk' => 80,'clean_address_geo_match' => 81,'clean_address_err_stat' => 82,'global_sid' => 83,'record_sid' => 84,'current_rec' => 85,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_rid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_bdid_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_bdid_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dotid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dotid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dotscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dotscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dotweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dotweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_empid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_empid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_empscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_empscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_empweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_empweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_powid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_powid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_powscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_powscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_powweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_powweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_proxid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_proxid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_proxscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_proxscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_proxweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_proxweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_seleid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_seleid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_selescore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_selescore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_seleweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_seleweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_orgscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_orgscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_orgweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_orgweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ultid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ultid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ultscore(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ultscore(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_ultweight(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ultweight(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_did_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_rawaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_aceaid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_aceaid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_row_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_rawfields_row_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_rawfields_row_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_rawfields_company_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_company_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_company_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_web_address(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_web_address(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_web_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_prefix(SALT311.StrType s0) := MakeFT_Invalid_AlphaChars(s0);
EXPORT InValid_rawfields_prefix(SALT311.StrType s) := InValidFT_Invalid_AlphaChars(s);
EXPORT InValidMessage_rawfields_prefix(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChars(wh);
 
EXPORT Make_rawfields_contact_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_contact_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_contact_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_first_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_first_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_first_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_middle_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_middle_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_middle_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_last_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_last_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_last_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_title(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_title(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_address(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_address(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_address(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_address1(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_address1(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_rawfields_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_rawfields_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_rawfields_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_rawfields_zip_code(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_rawfields_zip_code(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_rawfields_zip_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_rawfields_country(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_rawfields_country(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_rawfields_country(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_rawfields_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_rawfields_phone_number(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_rawfields_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_rawfields_email(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_rawfields_email(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_rawfields_email(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_clean_name_title(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_name_title(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_name_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_name_fname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_name_fname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_name_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_name_mname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_name_mname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_name_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_name_lname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_name_lname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_name_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_name_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_name_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_name_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_name_name_score(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_name_name_score(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_name_name_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_prim_range(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_clean_address_prim_range(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_clean_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_clean_address_predir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_predir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_prim_name(SALT311.StrType s0) := MakeFT_Invalid_PrintableChar(s0);
EXPORT InValid_clean_address_prim_name(SALT311.StrType s) := InValidFT_Invalid_PrintableChar(s);
EXPORT InValidMessage_clean_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_PrintableChar(wh);
 
EXPORT Make_clean_address_addr_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_addr_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_postdir(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_postdir(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_AlphaChars(s0);
EXPORT InValid_clean_address_unit_desig(SALT311.StrType s) := InValidFT_Invalid_AlphaChars(s);
EXPORT InValidMessage_clean_address_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChars(wh);
 
EXPORT Make_clean_address_sec_range(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_address_sec_range(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_address_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_address_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_st(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_clean_address_st(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_clean_address_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_clean_address_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_clean_address_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_clean_address_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_clean_address_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_cart(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_address_cart(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_address_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_clean_address_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_lot(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_lot(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_lot_order(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_dbpc(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_dbpc(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_chk_digit(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_rec_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clean_address_rec_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clean_address_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clean_address_fips_state(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_fips_state(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_fips_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_fips_county(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_fips_county(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_fips_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_address_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_address_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_address_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_clean_address_geo_long(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_clean_address_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_clean_address_msa(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_msa(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_geo_blk(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_geo_match(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_clean_address_geo_match(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_clean_address_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_clean_address_err_stat(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_clean_address_err_stat(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_clean_address_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_global_sid(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_global_sid(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_record_sid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_record_sid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_current_rec(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_current_rec(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_current_rec(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_SalesChannel;
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
    BOOLEAN Diff_rid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_rawfields_row_id;
    BOOLEAN Diff_rawfields_company_name;
    BOOLEAN Diff_rawfields_web_address;
    BOOLEAN Diff_rawfields_prefix;
    BOOLEAN Diff_rawfields_contact_name;
    BOOLEAN Diff_rawfields_first_name;
    BOOLEAN Diff_rawfields_middle_name;
    BOOLEAN Diff_rawfields_last_name;
    BOOLEAN Diff_rawfields_title;
    BOOLEAN Diff_rawfields_address;
    BOOLEAN Diff_rawfields_address1;
    BOOLEAN Diff_rawfields_city;
    BOOLEAN Diff_rawfields_state;
    BOOLEAN Diff_rawfields_zip_code;
    BOOLEAN Diff_rawfields_country;
    BOOLEAN Diff_rawfields_phone_number;
    BOOLEAN Diff_rawfields_email;
    BOOLEAN Diff_clean_name_title;
    BOOLEAN Diff_clean_name_fname;
    BOOLEAN Diff_clean_name_mname;
    BOOLEAN Diff_clean_name_lname;
    BOOLEAN Diff_clean_name_name_suffix;
    BOOLEAN Diff_clean_name_name_score;
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
    BOOLEAN Diff_clean_address_fips_state;
    BOOLEAN Diff_clean_address_fips_county;
    BOOLEAN Diff_clean_address_geo_lat;
    BOOLEAN Diff_clean_address_geo_long;
    BOOLEAN Diff_clean_address_msa;
    BOOLEAN Diff_clean_address_geo_blk;
    BOOLEAN Diff_clean_address_geo_match;
    BOOLEAN Diff_clean_address_err_stat;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    BOOLEAN Diff_current_rec;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_rid := le.rid <> ri.rid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
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
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_rawfields_row_id := le.rawfields_row_id <> ri.rawfields_row_id;
    SELF.Diff_rawfields_company_name := le.rawfields_company_name <> ri.rawfields_company_name;
    SELF.Diff_rawfields_web_address := le.rawfields_web_address <> ri.rawfields_web_address;
    SELF.Diff_rawfields_prefix := le.rawfields_prefix <> ri.rawfields_prefix;
    SELF.Diff_rawfields_contact_name := le.rawfields_contact_name <> ri.rawfields_contact_name;
    SELF.Diff_rawfields_first_name := le.rawfields_first_name <> ri.rawfields_first_name;
    SELF.Diff_rawfields_middle_name := le.rawfields_middle_name <> ri.rawfields_middle_name;
    SELF.Diff_rawfields_last_name := le.rawfields_last_name <> ri.rawfields_last_name;
    SELF.Diff_rawfields_title := le.rawfields_title <> ri.rawfields_title;
    SELF.Diff_rawfields_address := le.rawfields_address <> ri.rawfields_address;
    SELF.Diff_rawfields_address1 := le.rawfields_address1 <> ri.rawfields_address1;
    SELF.Diff_rawfields_city := le.rawfields_city <> ri.rawfields_city;
    SELF.Diff_rawfields_state := le.rawfields_state <> ri.rawfields_state;
    SELF.Diff_rawfields_zip_code := le.rawfields_zip_code <> ri.rawfields_zip_code;
    SELF.Diff_rawfields_country := le.rawfields_country <> ri.rawfields_country;
    SELF.Diff_rawfields_phone_number := le.rawfields_phone_number <> ri.rawfields_phone_number;
    SELF.Diff_rawfields_email := le.rawfields_email <> ri.rawfields_email;
    SELF.Diff_clean_name_title := le.clean_name_title <> ri.clean_name_title;
    SELF.Diff_clean_name_fname := le.clean_name_fname <> ri.clean_name_fname;
    SELF.Diff_clean_name_mname := le.clean_name_mname <> ri.clean_name_mname;
    SELF.Diff_clean_name_lname := le.clean_name_lname <> ri.clean_name_lname;
    SELF.Diff_clean_name_name_suffix := le.clean_name_name_suffix <> ri.clean_name_name_suffix;
    SELF.Diff_clean_name_name_score := le.clean_name_name_score <> ri.clean_name_name_score;
    SELF.Diff_clean_address_prim_range := le.clean_address_prim_range <> ri.clean_address_prim_range;
    SELF.Diff_clean_address_predir := le.clean_address_predir <> ri.clean_address_predir;
    SELF.Diff_clean_address_prim_name := le.clean_address_prim_name <> ri.clean_address_prim_name;
    SELF.Diff_clean_address_addr_suffix := le.clean_address_addr_suffix <> ri.clean_address_addr_suffix;
    SELF.Diff_clean_address_postdir := le.clean_address_postdir <> ri.clean_address_postdir;
    SELF.Diff_clean_address_unit_desig := le.clean_address_unit_desig <> ri.clean_address_unit_desig;
    SELF.Diff_clean_address_sec_range := le.clean_address_sec_range <> ri.clean_address_sec_range;
    SELF.Diff_clean_address_p_city_name := le.clean_address_p_city_name <> ri.clean_address_p_city_name;
    SELF.Diff_clean_address_v_city_name := le.clean_address_v_city_name <> ri.clean_address_v_city_name;
    SELF.Diff_clean_address_st := le.clean_address_st <> ri.clean_address_st;
    SELF.Diff_clean_address_zip := le.clean_address_zip <> ri.clean_address_zip;
    SELF.Diff_clean_address_zip4 := le.clean_address_zip4 <> ri.clean_address_zip4;
    SELF.Diff_clean_address_cart := le.clean_address_cart <> ri.clean_address_cart;
    SELF.Diff_clean_address_cr_sort_sz := le.clean_address_cr_sort_sz <> ri.clean_address_cr_sort_sz;
    SELF.Diff_clean_address_lot := le.clean_address_lot <> ri.clean_address_lot;
    SELF.Diff_clean_address_lot_order := le.clean_address_lot_order <> ri.clean_address_lot_order;
    SELF.Diff_clean_address_dbpc := le.clean_address_dbpc <> ri.clean_address_dbpc;
    SELF.Diff_clean_address_chk_digit := le.clean_address_chk_digit <> ri.clean_address_chk_digit;
    SELF.Diff_clean_address_rec_type := le.clean_address_rec_type <> ri.clean_address_rec_type;
    SELF.Diff_clean_address_fips_state := le.clean_address_fips_state <> ri.clean_address_fips_state;
    SELF.Diff_clean_address_fips_county := le.clean_address_fips_county <> ri.clean_address_fips_county;
    SELF.Diff_clean_address_geo_lat := le.clean_address_geo_lat <> ri.clean_address_geo_lat;
    SELF.Diff_clean_address_geo_long := le.clean_address_geo_long <> ri.clean_address_geo_long;
    SELF.Diff_clean_address_msa := le.clean_address_msa <> ri.clean_address_msa;
    SELF.Diff_clean_address_geo_blk := le.clean_address_geo_blk <> ri.clean_address_geo_blk;
    SELF.Diff_clean_address_geo_match := le.clean_address_geo_match <> ri.clean_address_geo_match;
    SELF.Diff_clean_address_err_stat := le.clean_address_err_stat <> ri.clean_address_err_stat;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Diff_current_rec := le.current_rec <> ri.current_rec;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_rid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_rawfields_row_id,1,0)+ IF( SELF.Diff_rawfields_company_name,1,0)+ IF( SELF.Diff_rawfields_web_address,1,0)+ IF( SELF.Diff_rawfields_prefix,1,0)+ IF( SELF.Diff_rawfields_contact_name,1,0)+ IF( SELF.Diff_rawfields_first_name,1,0)+ IF( SELF.Diff_rawfields_middle_name,1,0)+ IF( SELF.Diff_rawfields_last_name,1,0)+ IF( SELF.Diff_rawfields_title,1,0)+ IF( SELF.Diff_rawfields_address,1,0)+ IF( SELF.Diff_rawfields_address1,1,0)+ IF( SELF.Diff_rawfields_city,1,0)+ IF( SELF.Diff_rawfields_state,1,0)+ IF( SELF.Diff_rawfields_zip_code,1,0)+ IF( SELF.Diff_rawfields_country,1,0)+ IF( SELF.Diff_rawfields_phone_number,1,0)+ IF( SELF.Diff_rawfields_email,1,0)+ IF( SELF.Diff_clean_name_title,1,0)+ IF( SELF.Diff_clean_name_fname,1,0)+ IF( SELF.Diff_clean_name_mname,1,0)+ IF( SELF.Diff_clean_name_lname,1,0)+ IF( SELF.Diff_clean_name_name_suffix,1,0)+ IF( SELF.Diff_clean_name_name_score,1,0)+ IF( SELF.Diff_clean_address_prim_range,1,0)+ IF( SELF.Diff_clean_address_predir,1,0)+ IF( SELF.Diff_clean_address_prim_name,1,0)+ IF( SELF.Diff_clean_address_addr_suffix,1,0)+ IF( SELF.Diff_clean_address_postdir,1,0)+ IF( SELF.Diff_clean_address_unit_desig,1,0)+ IF( SELF.Diff_clean_address_sec_range,1,0)+ IF( SELF.Diff_clean_address_p_city_name,1,0)+ IF( SELF.Diff_clean_address_v_city_name,1,0)+ IF( SELF.Diff_clean_address_st,1,0)+ IF( SELF.Diff_clean_address_zip,1,0)+ IF( SELF.Diff_clean_address_zip4,1,0)+ IF( SELF.Diff_clean_address_cart,1,0)+ IF( SELF.Diff_clean_address_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_address_lot,1,0)+ IF( SELF.Diff_clean_address_lot_order,1,0)+ IF( SELF.Diff_clean_address_dbpc,1,0)+ IF( SELF.Diff_clean_address_chk_digit,1,0)+ IF( SELF.Diff_clean_address_rec_type,1,0)+ IF( SELF.Diff_clean_address_fips_state,1,0)+ IF( SELF.Diff_clean_address_fips_county,1,0)+ IF( SELF.Diff_clean_address_geo_lat,1,0)+ IF( SELF.Diff_clean_address_geo_long,1,0)+ IF( SELF.Diff_clean_address_msa,1,0)+ IF( SELF.Diff_clean_address_geo_blk,1,0)+ IF( SELF.Diff_clean_address_geo_match,1,0)+ IF( SELF.Diff_clean_address_err_stat,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0)+ IF( SELF.Diff_current_rec,1,0);
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
    Count_Diff_rid := COUNT(GROUP,%Closest%.Diff_rid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_rawfields_row_id := COUNT(GROUP,%Closest%.Diff_rawfields_row_id);
    Count_Diff_rawfields_company_name := COUNT(GROUP,%Closest%.Diff_rawfields_company_name);
    Count_Diff_rawfields_web_address := COUNT(GROUP,%Closest%.Diff_rawfields_web_address);
    Count_Diff_rawfields_prefix := COUNT(GROUP,%Closest%.Diff_rawfields_prefix);
    Count_Diff_rawfields_contact_name := COUNT(GROUP,%Closest%.Diff_rawfields_contact_name);
    Count_Diff_rawfields_first_name := COUNT(GROUP,%Closest%.Diff_rawfields_first_name);
    Count_Diff_rawfields_middle_name := COUNT(GROUP,%Closest%.Diff_rawfields_middle_name);
    Count_Diff_rawfields_last_name := COUNT(GROUP,%Closest%.Diff_rawfields_last_name);
    Count_Diff_rawfields_title := COUNT(GROUP,%Closest%.Diff_rawfields_title);
    Count_Diff_rawfields_address := COUNT(GROUP,%Closest%.Diff_rawfields_address);
    Count_Diff_rawfields_address1 := COUNT(GROUP,%Closest%.Diff_rawfields_address1);
    Count_Diff_rawfields_city := COUNT(GROUP,%Closest%.Diff_rawfields_city);
    Count_Diff_rawfields_state := COUNT(GROUP,%Closest%.Diff_rawfields_state);
    Count_Diff_rawfields_zip_code := COUNT(GROUP,%Closest%.Diff_rawfields_zip_code);
    Count_Diff_rawfields_country := COUNT(GROUP,%Closest%.Diff_rawfields_country);
    Count_Diff_rawfields_phone_number := COUNT(GROUP,%Closest%.Diff_rawfields_phone_number);
    Count_Diff_rawfields_email := COUNT(GROUP,%Closest%.Diff_rawfields_email);
    Count_Diff_clean_name_title := COUNT(GROUP,%Closest%.Diff_clean_name_title);
    Count_Diff_clean_name_fname := COUNT(GROUP,%Closest%.Diff_clean_name_fname);
    Count_Diff_clean_name_mname := COUNT(GROUP,%Closest%.Diff_clean_name_mname);
    Count_Diff_clean_name_lname := COUNT(GROUP,%Closest%.Diff_clean_name_lname);
    Count_Diff_clean_name_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_name_suffix);
    Count_Diff_clean_name_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_name_score);
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
    Count_Diff_clean_address_fips_state := COUNT(GROUP,%Closest%.Diff_clean_address_fips_state);
    Count_Diff_clean_address_fips_county := COUNT(GROUP,%Closest%.Diff_clean_address_fips_county);
    Count_Diff_clean_address_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_address_geo_lat);
    Count_Diff_clean_address_geo_long := COUNT(GROUP,%Closest%.Diff_clean_address_geo_long);
    Count_Diff_clean_address_msa := COUNT(GROUP,%Closest%.Diff_clean_address_msa);
    Count_Diff_clean_address_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_address_geo_blk);
    Count_Diff_clean_address_geo_match := COUNT(GROUP,%Closest%.Diff_clean_address_geo_match);
    Count_Diff_clean_address_err_stat := COUNT(GROUP,%Closest%.Diff_clean_address_err_stat);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    Count_Diff_current_rec := COUNT(GROUP,%Closest%.Diff_current_rec);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
