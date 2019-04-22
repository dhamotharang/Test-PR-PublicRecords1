IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_ace_rec_type','invalid_address','invalid_alpha','invalid_alphanumeric','invalid_alphanumericspacehyphen','invalid_alphaspacecommaslash','invalid_alphaspacecommaslashhyphenparenampquote','invalid_alphaspacehyphenquote','invalid_date','invalid_first_name','invalid_last_name','invalid_license_number','invalid_license_state','invalid_match_code','invalid_numeric','invalid_occupational_title','invalid_past_date','invalid_residential_business_ind','invalid_status_code','invalid_suffix','invalid_unit_type');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_ace_rec_type' => 1,'invalid_address' => 2,'invalid_alpha' => 3,'invalid_alphanumeric' => 4,'invalid_alphanumericspacehyphen' => 5,'invalid_alphaspacecommaslash' => 6,'invalid_alphaspacecommaslashhyphenparenampquote' => 7,'invalid_alphaspacehyphenquote' => 8,'invalid_date' => 9,'invalid_first_name' => 10,'invalid_last_name' => 11,'invalid_license_number' => 12,'invalid_license_state' => 13,'invalid_match_code' => 14,'invalid_numeric' => 15,'invalid_occupational_title' => 16,'invalid_past_date' => 17,'invalid_residential_business_ind' => 18,'invalid_status_code' => 19,'invalid_suffix' => 20,'invalid_unit_type' => 21,0);
 
EXPORT MakeFT_invalid_ace_rec_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_rec_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['F','G','H','M','P','R','S','U','FD','GD','HD','RD','SD','UD',' ']);
EXPORT InValidMessageFT_invalid_ace_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('F|G|H|M|P|R|S|U|FD|GD|HD|RD|SD|UD| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address(SALT37.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumericspacehyphen(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumericspacehyphen(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumericspacehyphen(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspacecommaslash(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspacecommaslash(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspacecommaslash(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspacecommaslashhyphenparenampquote(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ,/-()&\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspacecommaslashhyphenparenampquote(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ,/-()&\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspacecommaslashhyphenparenampquote(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' ,/-()&\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaspacehyphenquote(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaspacehyphenquote(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaspacehyphenquote(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_first_name(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_first_name(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_last_name(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_number(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' .-/$#+,:()&;`_*=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_number(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' .-/$#+,:()&;`_*=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' .-/$#+,:()&;`_*=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_state(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_license_state(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_license_state(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_match_code(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_match_code(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['0','2','4','X','P',' ']);
EXPORT InValidMessageFT_invalid_match_code(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('0|2|4|X|P| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_occupational_title(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,' ,/-()&ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_occupational_title(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,' ,/-()&ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_occupational_title(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars(' ,/-()&ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_past_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_residential_business_ind(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_residential_business_ind(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['B','U']);
EXPORT InValidMessageFT_invalid_residential_business_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('B|U'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status_code(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status_code(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['A','C','O','P','R','X',' '],~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_status_code(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('A|C|O|P|R|X| '),SALT37.HygieneErrors.NotLength('1..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_suffix(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_suffix(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['SR','JR','I','II','III','IV','V','VI','VII','VIII','IX',' ']);
EXPORT InValidMessageFT_invalid_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('SR|JR|I|II|III|IV|V|VI|VII|VIII|IX| '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_type(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_type(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['#','APT','BLDG','BOX','BSMT','DEPT','FL','FRNT','HNGR','KEY','LBBY','LOT','LOWR','OFC','PH','PIER','REAR','RM','SIDE','SLIP','SPC','STE','STOP','TRLR','UNIT','UPPR',' ']);
EXPORT InValidMessageFT_invalid_unit_type(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('#|APT|BLDG|BOX|BSMT|DEPT|FL|FRNT|HNGR|KEY|LBBY|LOT|LOWR|OFC|PH|PIER|REAR|RM|SIDE|SLIP|SPC|STE|STOP|TRLR|UNIT|UPPR| '),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'occupation_id','first_name','middle_name','last_name','suffix','address','prim_range','predir','prim_name','addr_suffix','postdir','unit_type','unit_number','city','state','zip','zip4','bar','ace_rec_type','cart','census_state_code','census_county_code','county_code_desc','census_tract','census_block_group','match_code','latitude','longitude','mail_score','residential_business_ind','employer_name','family_id','individual_id','abi_number','industry_title','occupation_title','specialty_title','sic_code','naics_group','license_state','license_id','license_number','exp_date','status_code','effective_date','add_date','change_date','year_licensed','carriage_return');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'occupation_id' => 0,'first_name' => 1,'middle_name' => 2,'last_name' => 3,'suffix' => 4,'address' => 5,'prim_range' => 6,'predir' => 7,'prim_name' => 8,'addr_suffix' => 9,'postdir' => 10,'unit_type' => 11,'unit_number' => 12,'city' => 13,'state' => 14,'zip' => 15,'zip4' => 16,'bar' => 17,'ace_rec_type' => 18,'cart' => 19,'census_state_code' => 20,'census_county_code' => 21,'county_code_desc' => 22,'census_tract' => 23,'census_block_group' => 24,'match_code' => 25,'latitude' => 26,'longitude' => 27,'mail_score' => 28,'residential_business_ind' => 29,'employer_name' => 30,'family_id' => 31,'individual_id' => 32,'abi_number' => 33,'industry_title' => 34,'occupation_title' => 35,'specialty_title' => 36,'sic_code' => 37,'naics_group' => 38,'license_state' => 39,'license_id' => 40,'license_number' => 41,'exp_date' => 42,'status_code' => 43,'effective_date' => 44,'add_date' => 45,'change_date' => 46,'year_licensed' => 47,'carriage_return' => 48,0);
 
//Individual field level validation
 
EXPORT Make_occupation_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_occupation_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_occupation_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_first_name(SALT37.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_first_name(SALT37.StrType s) := InValidFT_invalid_first_name(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
 
EXPORT Make_middle_name(SALT37.StrType s0) := MakeFT_invalid_alphaspacehyphenquote(s0);
EXPORT InValid_middle_name(SALT37.StrType s) := InValidFT_invalid_alphaspacehyphenquote(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacehyphenquote(wh);
 
EXPORT Make_last_name(SALT37.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT37.StrType s) := InValidFT_invalid_last_name(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_suffix(SALT37.StrType s0) := MakeFT_invalid_suffix(s0);
EXPORT InValid_suffix(SALT37.StrType s) := InValidFT_invalid_suffix(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_suffix(wh);
 
EXPORT Make_address(SALT37.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_address(SALT37.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_prim_range(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_predir(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_prim_name(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_addr_suffix(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_postdir(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_postdir(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_unit_type(SALT37.StrType s0) := MakeFT_invalid_unit_type(s0);
EXPORT InValid_unit_type(SALT37.StrType s) := InValidFT_invalid_unit_type(s);
EXPORT InValidMessage_unit_type(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_type(wh);
 
EXPORT Make_unit_number(SALT37.StrType s0) := s0;
EXPORT InValid_unit_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT37.StrType s0) := MakeFT_invalid_alphanumericspacehyphen(s0);
EXPORT InValid_city(SALT37.StrType s) := InValidFT_invalid_alphanumericspacehyphen(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumericspacehyphen(wh);
 
EXPORT Make_state(SALT37.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_state(SALT37.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_zip(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_zip4(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip4(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bar(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bar(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bar(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ace_rec_type(SALT37.StrType s0) := MakeFT_invalid_ace_rec_type(s0);
EXPORT InValid_ace_rec_type(SALT37.StrType s) := InValidFT_invalid_ace_rec_type(s);
EXPORT InValidMessage_ace_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_rec_type(wh);
 
EXPORT Make_cart(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_cart(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_census_state_code(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_census_state_code(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_census_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_census_county_code(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_census_county_code(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_census_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_county_code_desc(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county_code_desc(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county_code_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_census_tract(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_census_tract(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_census_tract(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_census_block_group(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_census_block_group(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_census_block_group(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_match_code(SALT37.StrType s0) := MakeFT_invalid_match_code(s0);
EXPORT InValid_match_code(SALT37.StrType s) := InValidFT_invalid_match_code(s);
EXPORT InValidMessage_match_code(UNSIGNED1 wh) := InValidMessageFT_invalid_match_code(wh);
 
EXPORT Make_latitude(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_latitude(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_longitude(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_longitude(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_mail_score(SALT37.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_mail_score(SALT37.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_residential_business_ind(SALT37.StrType s0) := MakeFT_invalid_residential_business_ind(s0);
EXPORT InValid_residential_business_ind(SALT37.StrType s) := InValidFT_invalid_residential_business_ind(s);
EXPORT InValidMessage_residential_business_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_residential_business_ind(wh);
 
EXPORT Make_employer_name(SALT37.StrType s0) := s0;
EXPORT InValid_employer_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_employer_name(UNSIGNED1 wh) := '';
 
EXPORT Make_family_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_family_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_family_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_individual_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_individual_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_individual_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_abi_number(SALT37.StrType s0) := s0;
EXPORT InValid_abi_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_abi_number(UNSIGNED1 wh) := '';
 
EXPORT Make_industry_title(SALT37.StrType s0) := MakeFT_invalid_alphaspacecommaslash(s0);
EXPORT InValid_industry_title(SALT37.StrType s) := InValidFT_invalid_alphaspacecommaslash(s);
EXPORT InValidMessage_industry_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacecommaslash(wh);
 
EXPORT Make_occupation_title(SALT37.StrType s0) := MakeFT_invalid_occupational_title(s0);
EXPORT InValid_occupation_title(SALT37.StrType s) := InValidFT_invalid_occupational_title(s);
EXPORT InValidMessage_occupation_title(UNSIGNED1 wh) := InValidMessageFT_invalid_occupational_title(wh);
 
EXPORT Make_specialty_title(SALT37.StrType s0) := MakeFT_invalid_alphaspacecommaslashhyphenparenampquote(s0);
EXPORT InValid_specialty_title(SALT37.StrType s) := InValidFT_invalid_alphaspacecommaslashhyphenparenampquote(s);
EXPORT InValidMessage_specialty_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaspacecommaslashhyphenparenampquote(wh);
 
EXPORT Make_sic_code(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sic_code(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_naics_group(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_naics_group(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_naics_group(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_license_state(SALT37.StrType s0) := MakeFT_invalid_license_state(s0);
EXPORT InValid_license_state(SALT37.StrType s) := InValidFT_invalid_license_state(s);
EXPORT InValidMessage_license_state(UNSIGNED1 wh) := InValidMessageFT_invalid_license_state(wh);
 
EXPORT Make_license_id(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_license_id(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_license_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_license_number(SALT37.StrType s0) := MakeFT_invalid_license_number(s0);
EXPORT InValid_license_number(SALT37.StrType s) := InValidFT_invalid_license_number(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_license_number(wh);
 
EXPORT Make_exp_date(SALT37.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_exp_date(SALT37.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_exp_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_status_code(SALT37.StrType s0) := MakeFT_invalid_status_code(s0);
EXPORT InValid_status_code(SALT37.StrType s) := InValidFT_invalid_status_code(s);
EXPORT InValidMessage_status_code(UNSIGNED1 wh) := InValidMessageFT_invalid_status_code(wh);
 
EXPORT Make_effective_date(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_effective_date(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_add_date(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_add_date(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_add_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_change_date(SALT37.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_change_date(SALT37.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_change_date(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_year_licensed(SALT37.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_year_licensed(SALT37.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_year_licensed(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_carriage_return(SALT37.StrType s0) := s0;
EXPORT InValid_carriage_return(SALT37.StrType s) := 0;
EXPORT InValidMessage_carriage_return(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_Infogroup;
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
    BOOLEAN Diff_occupation_id;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_address;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_type;
    BOOLEAN Diff_unit_number;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_bar;
    BOOLEAN Diff_ace_rec_type;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_census_state_code;
    BOOLEAN Diff_census_county_code;
    BOOLEAN Diff_county_code_desc;
    BOOLEAN Diff_census_tract;
    BOOLEAN Diff_census_block_group;
    BOOLEAN Diff_match_code;
    BOOLEAN Diff_latitude;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_residential_business_ind;
    BOOLEAN Diff_employer_name;
    BOOLEAN Diff_family_id;
    BOOLEAN Diff_individual_id;
    BOOLEAN Diff_abi_number;
    BOOLEAN Diff_industry_title;
    BOOLEAN Diff_occupation_title;
    BOOLEAN Diff_specialty_title;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_naics_group;
    BOOLEAN Diff_license_state;
    BOOLEAN Diff_license_id;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_exp_date;
    BOOLEAN Diff_status_code;
    BOOLEAN Diff_effective_date;
    BOOLEAN Diff_add_date;
    BOOLEAN Diff_change_date;
    BOOLEAN Diff_year_licensed;
    BOOLEAN Diff_carriage_return;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_occupation_id := le.occupation_id <> ri.occupation_id;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_type := le.unit_type <> ri.unit_type;
    SELF.Diff_unit_number := le.unit_number <> ri.unit_number;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_bar := le.bar <> ri.bar;
    SELF.Diff_ace_rec_type := le.ace_rec_type <> ri.ace_rec_type;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_census_state_code := le.census_state_code <> ri.census_state_code;
    SELF.Diff_census_county_code := le.census_county_code <> ri.census_county_code;
    SELF.Diff_county_code_desc := le.county_code_desc <> ri.county_code_desc;
    SELF.Diff_census_tract := le.census_tract <> ri.census_tract;
    SELF.Diff_census_block_group := le.census_block_group <> ri.census_block_group;
    SELF.Diff_match_code := le.match_code <> ri.match_code;
    SELF.Diff_latitude := le.latitude <> ri.latitude;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_residential_business_ind := le.residential_business_ind <> ri.residential_business_ind;
    SELF.Diff_employer_name := le.employer_name <> ri.employer_name;
    SELF.Diff_family_id := le.family_id <> ri.family_id;
    SELF.Diff_individual_id := le.individual_id <> ri.individual_id;
    SELF.Diff_abi_number := le.abi_number <> ri.abi_number;
    SELF.Diff_industry_title := le.industry_title <> ri.industry_title;
    SELF.Diff_occupation_title := le.occupation_title <> ri.occupation_title;
    SELF.Diff_specialty_title := le.specialty_title <> ri.specialty_title;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_naics_group := le.naics_group <> ri.naics_group;
    SELF.Diff_license_state := le.license_state <> ri.license_state;
    SELF.Diff_license_id := le.license_id <> ri.license_id;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_exp_date := le.exp_date <> ri.exp_date;
    SELF.Diff_status_code := le.status_code <> ri.status_code;
    SELF.Diff_effective_date := le.effective_date <> ri.effective_date;
    SELF.Diff_add_date := le.add_date <> ri.add_date;
    SELF.Diff_change_date := le.change_date <> ri.change_date;
    SELF.Diff_year_licensed := le.year_licensed <> ri.year_licensed;
    SELF.Diff_carriage_return := le.carriage_return <> ri.carriage_return;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_occupation_id,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_type,1,0)+ IF( SELF.Diff_unit_number,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_bar,1,0)+ IF( SELF.Diff_ace_rec_type,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_census_state_code,1,0)+ IF( SELF.Diff_census_county_code,1,0)+ IF( SELF.Diff_county_code_desc,1,0)+ IF( SELF.Diff_census_tract,1,0)+ IF( SELF.Diff_census_block_group,1,0)+ IF( SELF.Diff_match_code,1,0)+ IF( SELF.Diff_latitude,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_mail_score,1,0)+ IF( SELF.Diff_residential_business_ind,1,0)+ IF( SELF.Diff_employer_name,1,0)+ IF( SELF.Diff_family_id,1,0)+ IF( SELF.Diff_individual_id,1,0)+ IF( SELF.Diff_abi_number,1,0)+ IF( SELF.Diff_industry_title,1,0)+ IF( SELF.Diff_occupation_title,1,0)+ IF( SELF.Diff_specialty_title,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_naics_group,1,0)+ IF( SELF.Diff_license_state,1,0)+ IF( SELF.Diff_license_id,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_exp_date,1,0)+ IF( SELF.Diff_status_code,1,0)+ IF( SELF.Diff_effective_date,1,0)+ IF( SELF.Diff_add_date,1,0)+ IF( SELF.Diff_change_date,1,0)+ IF( SELF.Diff_year_licensed,1,0)+ IF( SELF.Diff_carriage_return,1,0);
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
    Count_Diff_occupation_id := COUNT(GROUP,%Closest%.Diff_occupation_id);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_type := COUNT(GROUP,%Closest%.Diff_unit_type);
    Count_Diff_unit_number := COUNT(GROUP,%Closest%.Diff_unit_number);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_bar := COUNT(GROUP,%Closest%.Diff_bar);
    Count_Diff_ace_rec_type := COUNT(GROUP,%Closest%.Diff_ace_rec_type);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_census_state_code := COUNT(GROUP,%Closest%.Diff_census_state_code);
    Count_Diff_census_county_code := COUNT(GROUP,%Closest%.Diff_census_county_code);
    Count_Diff_county_code_desc := COUNT(GROUP,%Closest%.Diff_county_code_desc);
    Count_Diff_census_tract := COUNT(GROUP,%Closest%.Diff_census_tract);
    Count_Diff_census_block_group := COUNT(GROUP,%Closest%.Diff_census_block_group);
    Count_Diff_match_code := COUNT(GROUP,%Closest%.Diff_match_code);
    Count_Diff_latitude := COUNT(GROUP,%Closest%.Diff_latitude);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_residential_business_ind := COUNT(GROUP,%Closest%.Diff_residential_business_ind);
    Count_Diff_employer_name := COUNT(GROUP,%Closest%.Diff_employer_name);
    Count_Diff_family_id := COUNT(GROUP,%Closest%.Diff_family_id);
    Count_Diff_individual_id := COUNT(GROUP,%Closest%.Diff_individual_id);
    Count_Diff_abi_number := COUNT(GROUP,%Closest%.Diff_abi_number);
    Count_Diff_industry_title := COUNT(GROUP,%Closest%.Diff_industry_title);
    Count_Diff_occupation_title := COUNT(GROUP,%Closest%.Diff_occupation_title);
    Count_Diff_specialty_title := COUNT(GROUP,%Closest%.Diff_specialty_title);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_naics_group := COUNT(GROUP,%Closest%.Diff_naics_group);
    Count_Diff_license_state := COUNT(GROUP,%Closest%.Diff_license_state);
    Count_Diff_license_id := COUNT(GROUP,%Closest%.Diff_license_id);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_exp_date := COUNT(GROUP,%Closest%.Diff_exp_date);
    Count_Diff_status_code := COUNT(GROUP,%Closest%.Diff_status_code);
    Count_Diff_effective_date := COUNT(GROUP,%Closest%.Diff_effective_date);
    Count_Diff_add_date := COUNT(GROUP,%Closest%.Diff_add_date);
    Count_Diff_change_date := COUNT(GROUP,%Closest%.Diff_change_date);
    Count_Diff_year_licensed := COUNT(GROUP,%Closest%.Diff_year_licensed);
    Count_Diff_carriage_return := COUNT(GROUP,%Closest%.Diff_carriage_return);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
