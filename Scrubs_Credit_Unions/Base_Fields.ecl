IMPORT SALT38;
IMPORT Scrubs_Credit_Unions; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 75;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_record_type','invalid_phone','invalid_cycle_date','invalid_join_number','invalid_siteid','invalid_address_type_code','invalid_zip_code','invalid_country','invalid_bdid','invalid_sitetypename','invalid_mainoffice','invalid_st_code','invalid_st_name','invalid_source_rec_id','invalid_charter','invalid_numeric','invalid_financial_num','invalid_numeric_or_blank','invalid_past_date','invalid_mandatory');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_record_type' => 1,'invalid_phone' => 2,'invalid_cycle_date' => 3,'invalid_join_number' => 4,'invalid_siteid' => 5,'invalid_address_type_code' => 6,'invalid_zip_code' => 7,'invalid_country' => 8,'invalid_bdid' => 9,'invalid_sitetypename' => 10,'invalid_mainoffice' => 11,'invalid_st_code' => 12,'invalid_st_name' => 13,'invalid_source_rec_id' => 14,'invalid_charter' => 15,'invalid_numeric' => 16,'invalid_financial_num' => 17,'invalid_numeric_or_blank' => 18,'invalid_past_date' => 19,'invalid_mandatory' => 20,0);
 
EXPORT MakeFT_invalid_record_type(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('C|H'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_verify_phone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cycle_date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cycle_date(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_valid_past_Date(s)>0);
EXPORT InValidMessageFT_invalid_cycle_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_valid_past_Date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_join_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_join_number(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_join_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric_or_blank'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_siteid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_siteid(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_siteid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric_or_blank'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['PHYSICAL','MAILING','']);
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('PHYSICAL|MAILING|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' 0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' 0123456789-'))));
EXPORT InValidMessageFT_invalid_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' 0123456789-'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_country(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_verify_country(s)>0);
EXPORT InValidMessageFT_invalid_country(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_verify_country'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bdid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bdid(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_bdid(s)>0);
EXPORT InValidMessageFT_invalid_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_bdid'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sitetypename(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sitetypename(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['BRANCH OFFICE','CORPORATE OFFICE','']);
EXPORT InValidMessageFT_invalid_sitetypename(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('BRANCH OFFICE|CORPORATE OFFICE|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mainoffice(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mainoffice(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['YES','NO','']);
EXPORT InValidMessageFT_invalid_mainoffice(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('YES|NO|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st_code(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_verify_st_code(s)>0);
EXPORT InValidMessageFT_invalid_st_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_verify_st_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st_name(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_verify_state_name(s)>0);
EXPORT InValidMessageFT_invalid_st_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_verify_state_name'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_rec_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_rec_id(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_source_rec_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_charter(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_financial_num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' 0123456789-.Ee'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_financial_num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' 0123456789-.Ee'))));
EXPORT InValidMessageFT_invalid_financial_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' 0123456789-.Ee'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_numeric_or_blank'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT38.StrType s) := WHICH(~Scrubs_Credit_Unions.Functions.fn_valid_past_Date(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Credit_Unions.Functions.fn_valid_past_Date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','source_rec_id','bdid','record_type','raw_aid','ace_aid','dt_vendor_first_reported','dt_vendor_last_reported','charter','cycle_date','join_number','siteid','cu_name','sitename','sitetypename','mainoffice','addrtype','address1','address2','city','state','statename','zip_code','countyname','country','phone','contact_name','assets','loans','networthratio','perc_sharegrowth','perc_loangrowth','loantoassetsratio','investassetsratio','nummem','numfull','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','prep_addr_line1','prep_addr_line_last');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','source_rec_id','bdid','record_type','raw_aid','ace_aid','dt_vendor_first_reported','dt_vendor_last_reported','charter','cycle_date','join_number','siteid','cu_name','sitename','sitetypename','mainoffice','addrtype','address1','address2','city','state','statename','zip_code','countyname','country','phone','contact_name','assets','loans','networthratio','perc_sharegrowth','perc_loangrowth','loantoassetsratio','investassetsratio','nummem','numfull','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','prep_addr_line1','prep_addr_line_last');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'source_rec_id' => 5,'bdid' => 6,'record_type' => 7,'raw_aid' => 8,'ace_aid' => 9,'dt_vendor_first_reported' => 10,'dt_vendor_last_reported' => 11,'charter' => 12,'cycle_date' => 13,'join_number' => 14,'siteid' => 15,'cu_name' => 16,'sitename' => 17,'sitetypename' => 18,'mainoffice' => 19,'addrtype' => 20,'address1' => 21,'address2' => 22,'city' => 23,'state' => 24,'statename' => 25,'zip_code' => 26,'countyname' => 27,'country' => 28,'phone' => 29,'contact_name' => 30,'assets' => 31,'loans' => 32,'networthratio' => 33,'perc_sharegrowth' => 34,'perc_loangrowth' => 35,'loantoassetsratio' => 36,'investassetsratio' => 37,'nummem' => 38,'numfull' => 39,'title' => 40,'fname' => 41,'mname' => 42,'lname' => 43,'name_suffix' => 44,'name_score' => 45,'prim_range' => 46,'predir' => 47,'prim_name' => 48,'addr_suffix' => 49,'postdir' => 50,'unit_desig' => 51,'sec_range' => 52,'p_city_name' => 53,'v_city_name' => 54,'st' => 55,'zip' => 56,'zip4' => 57,'cart' => 58,'cr_sort_sz' => 59,'lot' => 60,'lot_order' => 61,'dbpc' => 62,'chk_digit' => 63,'rec_type' => 64,'fips_state' => 65,'fips_county' => 66,'geo_lat' => 67,'geo_long' => 68,'msa' => 69,'geo_blk' => 70,'geo_match' => 71,'err_stat' => 72,'prep_addr_line1' => 73,'prep_addr_line_last' => 74,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],[],['ENUM'],['ENUM'],['ENUM'],[],[],[],['CUSTOM'],['CUSTOM'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_invalid_source_rec_id(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_invalid_source_rec_id(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_source_rec_id(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_invalid_bdid(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_invalid_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_bdid(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT38.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_raw_aid(SALT38.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_raw_aid(SALT38.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_ace_aid(SALT38.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_ace_aid(SALT38.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_charter(SALT38.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_charter(SALT38.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_charter(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_cycle_date(SALT38.StrType s0) := MakeFT_invalid_cycle_date(s0);
EXPORT InValid_cycle_date(SALT38.StrType s) := InValidFT_invalid_cycle_date(s);
EXPORT InValidMessage_cycle_date(UNSIGNED1 wh) := InValidMessageFT_invalid_cycle_date(wh);
 
EXPORT Make_join_number(SALT38.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_join_number(SALT38.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_join_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_siteid(SALT38.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_siteid(SALT38.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_siteid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_cu_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_cu_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_cu_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_sitename(SALT38.StrType s0) := s0;
EXPORT InValid_sitename(SALT38.StrType s) := 0;
EXPORT InValidMessage_sitename(UNSIGNED1 wh) := '';
 
EXPORT Make_sitetypename(SALT38.StrType s0) := MakeFT_invalid_sitetypename(s0);
EXPORT InValid_sitetypename(SALT38.StrType s) := InValidFT_invalid_sitetypename(s);
EXPORT InValidMessage_sitetypename(UNSIGNED1 wh) := InValidMessageFT_invalid_sitetypename(wh);
 
EXPORT Make_mainoffice(SALT38.StrType s0) := MakeFT_invalid_mainoffice(s0);
EXPORT InValid_mainoffice(SALT38.StrType s) := InValidFT_invalid_mainoffice(s);
EXPORT InValidMessage_mainoffice(UNSIGNED1 wh) := InValidMessageFT_invalid_mainoffice(wh);
 
EXPORT Make_addrtype(SALT38.StrType s0) := MakeFT_invalid_address_type_code(s0);
EXPORT InValid_addrtype(SALT38.StrType s) := InValidFT_invalid_address_type_code(s);
EXPORT InValidMessage_addrtype(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type_code(wh);
 
EXPORT Make_address1(SALT38.StrType s0) := s0;
EXPORT InValid_address1(SALT38.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT38.StrType s0) := s0;
EXPORT InValid_address2(SALT38.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT38.StrType s0) := s0;
EXPORT InValid_city(SALT38.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_st_code(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_st_code(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st_code(wh);
 
EXPORT Make_statename(SALT38.StrType s0) := MakeFT_invalid_st_name(s0);
EXPORT InValid_statename(SALT38.StrType s) := InValidFT_invalid_st_name(s);
EXPORT InValidMessage_statename(UNSIGNED1 wh) := InValidMessageFT_invalid_st_name(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := MakeFT_invalid_zip_code(s0);
EXPORT InValid_zip_code(SALT38.StrType s) := InValidFT_invalid_zip_code(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code(wh);
 
EXPORT Make_countyname(SALT38.StrType s0) := s0;
EXPORT InValid_countyname(SALT38.StrType s) := 0;
EXPORT InValidMessage_countyname(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT38.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_country(SALT38.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
 
EXPORT Make_phone(SALT38.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_contact_name(SALT38.StrType s0) := s0;
EXPORT InValid_contact_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_contact_name(UNSIGNED1 wh) := '';
 
EXPORT Make_assets(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_assets(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_assets(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_loans(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_loans(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_loans(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_networthratio(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_networthratio(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_networthratio(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_perc_sharegrowth(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_perc_sharegrowth(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_perc_sharegrowth(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_perc_loangrowth(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_perc_loangrowth(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_perc_loangrowth(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_loantoassetsratio(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_loantoassetsratio(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_loantoassetsratio(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_investassetsratio(SALT38.StrType s0) := MakeFT_invalid_financial_num(s0);
EXPORT InValid_investassetsratio(SALT38.StrType s) := InValidFT_invalid_financial_num(s);
EXPORT InValidMessage_investassetsratio(UNSIGNED1 wh) := InValidMessageFT_invalid_financial_num(wh);
 
EXPORT Make_nummem(SALT38.StrType s0) := s0;
EXPORT InValid_nummem(SALT38.StrType s) := 0;
EXPORT InValidMessage_nummem(UNSIGNED1 wh) := '';
 
EXPORT Make_numfull(SALT38.StrType s0) := s0;
EXPORT InValid_numfull(SALT38.StrType s) := 0;
EXPORT InValidMessage_numfull(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_st(SALT38.StrType s0) := s0;
EXPORT InValid_st(SALT38.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT38.StrType s0) := s0;
EXPORT InValid_zip(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT38.StrType s0) := s0;
EXPORT InValid_zip4(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_dbpc(SALT38.StrType s0) := s0;
EXPORT InValid_dbpc(SALT38.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT38.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT38.StrType s0) := s0;
EXPORT InValid_fips_state(SALT38.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT38.StrType s0) := s0;
EXPORT InValid_fips_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT38.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT38.StrType s0) := s0;
EXPORT InValid_geo_long(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT38.StrType s0) := s0;
EXPORT InValid_msa(SALT38.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := s0;
EXPORT InValid_geo_match(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT38.StrType s0) := s0;
EXPORT InValid_err_stat(SALT38.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_line1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Credit_Unions;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_source_rec_id;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_charter;
    BOOLEAN Diff_cycle_date;
    BOOLEAN Diff_join_number;
    BOOLEAN Diff_siteid;
    BOOLEAN Diff_cu_name;
    BOOLEAN Diff_sitename;
    BOOLEAN Diff_sitetypename;
    BOOLEAN Diff_mainoffice;
    BOOLEAN Diff_addrtype;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_statename;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_countyname;
    BOOLEAN Diff_country;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_contact_name;
    BOOLEAN Diff_assets;
    BOOLEAN Diff_loans;
    BOOLEAN Diff_networthratio;
    BOOLEAN Diff_perc_sharegrowth;
    BOOLEAN Diff_perc_loangrowth;
    BOOLEAN Diff_loantoassetsratio;
    BOOLEAN Diff_investassetsratio;
    BOOLEAN Diff_nummem;
    BOOLEAN Diff_numfull;
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
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_charter := le.charter <> ri.charter;
    SELF.Diff_cycle_date := le.cycle_date <> ri.cycle_date;
    SELF.Diff_join_number := le.join_number <> ri.join_number;
    SELF.Diff_siteid := le.siteid <> ri.siteid;
    SELF.Diff_cu_name := le.cu_name <> ri.cu_name;
    SELF.Diff_sitename := le.sitename <> ri.sitename;
    SELF.Diff_sitetypename := le.sitetypename <> ri.sitetypename;
    SELF.Diff_mainoffice := le.mainoffice <> ri.mainoffice;
    SELF.Diff_addrtype := le.addrtype <> ri.addrtype;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_statename := le.statename <> ri.statename;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_countyname := le.countyname <> ri.countyname;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_contact_name := le.contact_name <> ri.contact_name;
    SELF.Diff_assets := le.assets <> ri.assets;
    SELF.Diff_loans := le.loans <> ri.loans;
    SELF.Diff_networthratio := le.networthratio <> ri.networthratio;
    SELF.Diff_perc_sharegrowth := le.perc_sharegrowth <> ri.perc_sharegrowth;
    SELF.Diff_perc_loangrowth := le.perc_loangrowth <> ri.perc_loangrowth;
    SELF.Diff_loantoassetsratio := le.loantoassetsratio <> ri.loantoassetsratio;
    SELF.Diff_investassetsratio := le.investassetsratio <> ri.investassetsratio;
    SELF.Diff_nummem := le.nummem <> ri.nummem;
    SELF.Diff_numfull := le.numfull <> ri.numfull;
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
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_charter,1,0)+ IF( SELF.Diff_cycle_date,1,0)+ IF( SELF.Diff_join_number,1,0)+ IF( SELF.Diff_siteid,1,0)+ IF( SELF.Diff_cu_name,1,0)+ IF( SELF.Diff_sitename,1,0)+ IF( SELF.Diff_sitetypename,1,0)+ IF( SELF.Diff_mainoffice,1,0)+ IF( SELF.Diff_addrtype,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_statename,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_countyname,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_contact_name,1,0)+ IF( SELF.Diff_assets,1,0)+ IF( SELF.Diff_loans,1,0)+ IF( SELF.Diff_networthratio,1,0)+ IF( SELF.Diff_perc_sharegrowth,1,0)+ IF( SELF.Diff_perc_loangrowth,1,0)+ IF( SELF.Diff_loantoassetsratio,1,0)+ IF( SELF.Diff_investassetsratio,1,0)+ IF( SELF.Diff_nummem,1,0)+ IF( SELF.Diff_numfull,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_charter := COUNT(GROUP,%Closest%.Diff_charter);
    Count_Diff_cycle_date := COUNT(GROUP,%Closest%.Diff_cycle_date);
    Count_Diff_join_number := COUNT(GROUP,%Closest%.Diff_join_number);
    Count_Diff_siteid := COUNT(GROUP,%Closest%.Diff_siteid);
    Count_Diff_cu_name := COUNT(GROUP,%Closest%.Diff_cu_name);
    Count_Diff_sitename := COUNT(GROUP,%Closest%.Diff_sitename);
    Count_Diff_sitetypename := COUNT(GROUP,%Closest%.Diff_sitetypename);
    Count_Diff_mainoffice := COUNT(GROUP,%Closest%.Diff_mainoffice);
    Count_Diff_addrtype := COUNT(GROUP,%Closest%.Diff_addrtype);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_statename := COUNT(GROUP,%Closest%.Diff_statename);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_countyname := COUNT(GROUP,%Closest%.Diff_countyname);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_contact_name := COUNT(GROUP,%Closest%.Diff_contact_name);
    Count_Diff_assets := COUNT(GROUP,%Closest%.Diff_assets);
    Count_Diff_loans := COUNT(GROUP,%Closest%.Diff_loans);
    Count_Diff_networthratio := COUNT(GROUP,%Closest%.Diff_networthratio);
    Count_Diff_perc_sharegrowth := COUNT(GROUP,%Closest%.Diff_perc_sharegrowth);
    Count_Diff_perc_loangrowth := COUNT(GROUP,%Closest%.Diff_perc_loangrowth);
    Count_Diff_loantoassetsratio := COUNT(GROUP,%Closest%.Diff_loantoassetsratio);
    Count_Diff_investassetsratio := COUNT(GROUP,%Closest%.Diff_investassetsratio);
    Count_Diff_nummem := COUNT(GROUP,%Closest%.Diff_nummem);
    Count_Diff_numfull := COUNT(GROUP,%Closest%.Diff_numfull);
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
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
