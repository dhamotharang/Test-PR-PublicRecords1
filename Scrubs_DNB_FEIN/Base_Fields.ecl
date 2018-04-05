IMPORT SALT38;
IMPORT Scrubs_DNB_FEIN; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 87;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_zero_integer','invalid_percentage','invalid_pastdate8','invalid_tmsid','invalid_bdid','invalid_orig_state','invalid_orig_zip5','invalid_fein','invalid_source_duns_number','invalid_case_duns_number','invalid_confidence_code','invalid_indirect_direct_source_ind','invalid_best_fein_indicator','invalid_sic_code','invalid_telephone_number','invalid_hdqtr_parent_duns_number','invalid_lname','invalid_source_rec_id','invalid_weight');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_zero_integer' => 2,'invalid_percentage' => 3,'invalid_pastdate8' => 4,'invalid_tmsid' => 5,'invalid_bdid' => 6,'invalid_orig_state' => 7,'invalid_orig_zip5' => 8,'invalid_fein' => 9,'invalid_source_duns_number' => 10,'invalid_case_duns_number' => 11,'invalid_confidence_code' => 12,'invalid_indirect_direct_source_ind' => 13,'invalid_best_fein_indicator' => 14,'invalid_sic_code' => 15,'invalid_telephone_number' => 16,'invalid_hdqtr_parent_duns_number' => 17,'invalid_lname' => 18,'invalid_source_rec_id' => 19,'invalid_weight' => 20,0);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_populated_strings'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_integer(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_integer(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_integer(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('0|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_past_yyyymmdd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tmsid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tmsid(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_tmsid(s)>0);
EXPORT InValidMessageFT_invalid_tmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_tmsid'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bdid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bdid(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,12)>0);
EXPORT InValidMessageFT_invalid_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_state(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip5(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_zip5(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_orig_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fein(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fein(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_fein(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_duns_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_duns_number(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_source_duns_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_case_duns_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_case_duns_number(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_case_duns_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_confidence_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_confidence_code(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_confidence_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_indirect_direct_source_ind(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_indirect_direct_source_ind(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2']);
EXPORT InValidMessageFT_invalid_indirect_direct_source_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_best_fein_indicator(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_best_fein_indicator(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','']);
EXPORT InValidMessageFT_invalid_best_fein_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_sic_code(s)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_sic_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_telephone_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_telephone_number(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_telephone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_verify_phone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hdqtr_parent_duns_number(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hdqtr_parent_duns_number(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_duns(s)>0);
EXPORT InValidMessageFT_invalid_hdqtr_parent_duns_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_duns'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType fname,SALT38.StrType top_contact_name) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_valid_name(s,mname,fname,top_contact_name)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_valid_name'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_rec_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_rec_id(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_source_rec_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_weight(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_weight(SALT38.StrType s) := WHICH(~Scrubs_DNB_FEIN.Functions.fn_range_numeric(s,0,999)>0);
EXPORT InValidMessageFT_invalid_weight(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DNB_FEIN.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tmsid','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','orig_company_name','clean_cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','fein','source_duns_number','case_duns_number','duns_orig_source','confidence_code','indirect_direct_source_ind','best_fein_indicator','company_name','trade_style','sic_code','telephone_number','top_contact_name','top_contact_title','hdqtr_parent_duns_number','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'tmsid','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','orig_company_name','clean_cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','fein','source_duns_number','case_duns_number','duns_orig_source','confidence_code','indirect_direct_source_ind','best_fein_indicator','company_name','trade_style','sic_code','telephone_number','top_contact_name','top_contact_title','hdqtr_parent_duns_number','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'tmsid' => 0,'bdid' => 1,'date_first_seen' => 2,'date_last_seen' => 3,'date_vendor_first_reported' => 4,'date_vendor_last_reported' => 5,'orig_company_name' => 6,'clean_cname' => 7,'orig_address1' => 8,'orig_address2' => 9,'orig_city' => 10,'orig_state' => 11,'orig_zip5' => 12,'orig_zip4' => 13,'orig_county' => 14,'fein' => 15,'source_duns_number' => 16,'case_duns_number' => 17,'duns_orig_source' => 18,'confidence_code' => 19,'indirect_direct_source_ind' => 20,'best_fein_indicator' => 21,'company_name' => 22,'trade_style' => 23,'sic_code' => 24,'telephone_number' => 25,'top_contact_name' => 26,'top_contact_title' => 27,'hdqtr_parent_duns_number' => 28,'title' => 29,'fname' => 30,'mname' => 31,'lname' => 32,'name_suffix' => 33,'name_score' => 34,'prim_range' => 35,'predir' => 36,'prim_name' => 37,'addr_suffix' => 38,'postdir' => 39,'unit_desig' => 40,'sec_range' => 41,'p_city_name' => 42,'v_city_name' => 43,'st' => 44,'zip' => 45,'zip4' => 46,'cart' => 47,'cr_sort_sz' => 48,'lot' => 49,'lot_order' => 50,'dbpc' => 51,'chk_digit' => 52,'rec_type' => 53,'county' => 54,'geo_lat' => 55,'geo_long' => 56,'msa' => 57,'geo_blk' => 58,'geo_match' => 59,'err_stat' => 60,'raw_aid' => 61,'ace_aid' => 62,'prep_addr_line1' => 63,'prep_addr_line_last' => 64,'source_rec_id' => 65,'dotid' => 66,'dotscore' => 67,'dotweight' => 68,'empid' => 69,'empscore' => 70,'empweight' => 71,'powid' => 72,'powscore' => 73,'powweight' => 74,'proxid' => 75,'proxscore' => 76,'proxweight' => 77,'seleid' => 78,'selescore' => 79,'seleweight' => 80,'orgid' => 81,'orgscore' => 82,'orgweight' => 83,'ultid' => 84,'ultscore' => 85,'ultweight' => 86,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],[],['CUSTOM'],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_tmsid(SALT38.StrType s0) := MakeFT_invalid_tmsid(s0);
EXPORT InValid_tmsid(SALT38.StrType s) := InValidFT_invalid_tmsid(s);
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := InValidMessageFT_invalid_tmsid(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_invalid_bdid(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_invalid_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_bdid(wh);
 
EXPORT Make_date_first_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_first_seen(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_date_last_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_last_seen(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_date_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_date_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_orig_company_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_company_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_cname(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_cname(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_cname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_address1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_address1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_address2(SALT38.StrType s0) := s0;
EXPORT InValid_orig_address2(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_state(SALT38.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_orig_state(SALT38.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_orig_zip5(SALT38.StrType s0) := MakeFT_invalid_orig_zip5(s0);
EXPORT InValid_orig_zip5(SALT38.StrType s) := InValidFT_invalid_orig_zip5(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip5(wh);
 
EXPORT Make_orig_zip4(SALT38.StrType s0) := s0;
EXPORT InValid_orig_zip4(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_county(SALT38.StrType s0) := s0;
EXPORT InValid_orig_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_county(UNSIGNED1 wh) := '';
 
EXPORT Make_fein(SALT38.StrType s0) := MakeFT_invalid_fein(s0);
EXPORT InValid_fein(SALT38.StrType s) := InValidFT_invalid_fein(s);
EXPORT InValidMessage_fein(UNSIGNED1 wh) := InValidMessageFT_invalid_fein(wh);
 
EXPORT Make_source_duns_number(SALT38.StrType s0) := MakeFT_invalid_source_duns_number(s0);
EXPORT InValid_source_duns_number(SALT38.StrType s) := InValidFT_invalid_source_duns_number(s);
EXPORT InValidMessage_source_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_source_duns_number(wh);
 
EXPORT Make_case_duns_number(SALT38.StrType s0) := MakeFT_invalid_case_duns_number(s0);
EXPORT InValid_case_duns_number(SALT38.StrType s) := InValidFT_invalid_case_duns_number(s);
EXPORT InValidMessage_case_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_case_duns_number(wh);
 
EXPORT Make_duns_orig_source(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_duns_orig_source(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_duns_orig_source(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_confidence_code(SALT38.StrType s0) := MakeFT_invalid_confidence_code(s0);
EXPORT InValid_confidence_code(SALT38.StrType s) := InValidFT_invalid_confidence_code(s);
EXPORT InValidMessage_confidence_code(UNSIGNED1 wh) := InValidMessageFT_invalid_confidence_code(wh);
 
EXPORT Make_indirect_direct_source_ind(SALT38.StrType s0) := MakeFT_invalid_indirect_direct_source_ind(s0);
EXPORT InValid_indirect_direct_source_ind(SALT38.StrType s) := InValidFT_invalid_indirect_direct_source_ind(s);
EXPORT InValidMessage_indirect_direct_source_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_indirect_direct_source_ind(wh);
 
EXPORT Make_best_fein_indicator(SALT38.StrType s0) := MakeFT_invalid_best_fein_indicator(s0);
EXPORT InValid_best_fein_indicator(SALT38.StrType s) := InValidFT_invalid_best_fein_indicator(s);
EXPORT InValidMessage_best_fein_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_best_fein_indicator(wh);
 
EXPORT Make_company_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_company_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_trade_style(SALT38.StrType s0) := s0;
EXPORT InValid_trade_style(SALT38.StrType s) := 0;
EXPORT InValidMessage_trade_style(UNSIGNED1 wh) := '';
 
EXPORT Make_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_telephone_number(SALT38.StrType s0) := MakeFT_invalid_telephone_number(s0);
EXPORT InValid_telephone_number(SALT38.StrType s) := InValidFT_invalid_telephone_number(s);
EXPORT InValidMessage_telephone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_telephone_number(wh);
 
EXPORT Make_top_contact_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_top_contact_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_top_contact_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_top_contact_title(SALT38.StrType s0) := s0;
EXPORT InValid_top_contact_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_top_contact_title(UNSIGNED1 wh) := '';
 
EXPORT Make_hdqtr_parent_duns_number(SALT38.StrType s0) := MakeFT_invalid_hdqtr_parent_duns_number(s0);
EXPORT InValid_hdqtr_parent_duns_number(SALT38.StrType s) := InValidFT_invalid_hdqtr_parent_duns_number(s);
EXPORT InValidMessage_hdqtr_parent_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_hdqtr_parent_duns_number(wh);
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := s0;
EXPORT InValid_fname(SALT38.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT38.StrType s0) := s0;
EXPORT InValid_mname(SALT38.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT38.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_lname(SALT38.StrType s,SALT38.StrType mname,SALT38.StrType fname,SALT38.StrType top_contact_name) := InValidFT_invalid_lname(s,mname,fname,top_contact_name);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
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
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
 
EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
 
EXPORT Make_county(SALT38.StrType s0) := s0;
EXPORT InValid_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_raw_aid(SALT38.StrType s0) := s0;
EXPORT InValid_raw_aid(SALT38.StrType s) := 0;
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_aid(SALT38.StrType s0) := s0;
EXPORT InValid_ace_aid(SALT38.StrType s) := 0;
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_line1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_invalid_source_rec_id(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_invalid_source_rec_id(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_source_rec_id(wh);
 
EXPORT Make_dotid(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotid(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotscore(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotscore(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_dotweight(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_dotweight(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empid(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empid(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empscore(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empscore(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_empweight(SALT38.StrType s0) := MakeFT_invalid_zero_integer(s0);
EXPORT InValid_empweight(SALT38.StrType s) := InValidFT_invalid_zero_integer(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_integer(wh);
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_powscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_powscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_powweight(SALT38.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_powweight(SALT38.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_proxscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_proxscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_proxweight(SALT38.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_proxweight(SALT38.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_selescore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_selescore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_seleweight(SALT38.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_seleweight(SALT38.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orgscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_orgscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_orgweight(SALT38.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_orgweight(SALT38.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ultscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_ultscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_ultweight(SALT38.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_ultweight(SALT38.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_DNB_FEIN;
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
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_orig_company_name;
    BOOLEAN Diff_clean_cname;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_county;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_source_duns_number;
    BOOLEAN Diff_case_duns_number;
    BOOLEAN Diff_duns_orig_source;
    BOOLEAN Diff_confidence_code;
    BOOLEAN Diff_indirect_direct_source_ind;
    BOOLEAN Diff_best_fein_indicator;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_trade_style;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_telephone_number;
    BOOLEAN Diff_top_contact_name;
    BOOLEAN Diff_top_contact_title;
    BOOLEAN Diff_hdqtr_parent_duns_number;
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
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_source_rec_id;
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
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_orig_company_name := le.orig_company_name <> ri.orig_company_name;
    SELF.Diff_clean_cname := le.clean_cname <> ri.clean_cname;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_county := le.orig_county <> ri.orig_county;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_source_duns_number := le.source_duns_number <> ri.source_duns_number;
    SELF.Diff_case_duns_number := le.case_duns_number <> ri.case_duns_number;
    SELF.Diff_duns_orig_source := le.duns_orig_source <> ri.duns_orig_source;
    SELF.Diff_confidence_code := le.confidence_code <> ri.confidence_code;
    SELF.Diff_indirect_direct_source_ind := le.indirect_direct_source_ind <> ri.indirect_direct_source_ind;
    SELF.Diff_best_fein_indicator := le.best_fein_indicator <> ri.best_fein_indicator;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_trade_style := le.trade_style <> ri.trade_style;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_telephone_number := le.telephone_number <> ri.telephone_number;
    SELF.Diff_top_contact_name := le.top_contact_name <> ri.top_contact_name;
    SELF.Diff_top_contact_title := le.top_contact_title <> ri.top_contact_title;
    SELF.Diff_hdqtr_parent_duns_number := le.hdqtr_parent_duns_number <> ri.hdqtr_parent_duns_number;
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
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
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
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_orig_company_name,1,0)+ IF( SELF.Diff_clean_cname,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_source_duns_number,1,0)+ IF( SELF.Diff_case_duns_number,1,0)+ IF( SELF.Diff_duns_orig_source,1,0)+ IF( SELF.Diff_confidence_code,1,0)+ IF( SELF.Diff_indirect_direct_source_ind,1,0)+ IF( SELF.Diff_best_fein_indicator,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_trade_style,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_telephone_number,1,0)+ IF( SELF.Diff_top_contact_name,1,0)+ IF( SELF.Diff_top_contact_title,1,0)+ IF( SELF.Diff_hdqtr_parent_duns_number,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_orig_company_name := COUNT(GROUP,%Closest%.Diff_orig_company_name);
    Count_Diff_clean_cname := COUNT(GROUP,%Closest%.Diff_clean_cname);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_county := COUNT(GROUP,%Closest%.Diff_orig_county);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_source_duns_number := COUNT(GROUP,%Closest%.Diff_source_duns_number);
    Count_Diff_case_duns_number := COUNT(GROUP,%Closest%.Diff_case_duns_number);
    Count_Diff_duns_orig_source := COUNT(GROUP,%Closest%.Diff_duns_orig_source);
    Count_Diff_confidence_code := COUNT(GROUP,%Closest%.Diff_confidence_code);
    Count_Diff_indirect_direct_source_ind := COUNT(GROUP,%Closest%.Diff_indirect_direct_source_ind);
    Count_Diff_best_fein_indicator := COUNT(GROUP,%Closest%.Diff_best_fein_indicator);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_trade_style := COUNT(GROUP,%Closest%.Diff_trade_style);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_telephone_number := COUNT(GROUP,%Closest%.Diff_telephone_number);
    Count_Diff_top_contact_name := COUNT(GROUP,%Closest%.Diff_top_contact_name);
    Count_Diff_top_contact_title := COUNT(GROUP,%Closest%.Diff_top_contact_title);
    Count_Diff_hdqtr_parent_duns_number := COUNT(GROUP,%Closest%.Diff_hdqtr_parent_duns_number);
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
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
