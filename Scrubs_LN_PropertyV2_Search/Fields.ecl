IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 87;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_LNFaresID','Invalid_SourceCode','Invalid_Num','Invalid_Char','Invalid_RecType','Invalid_PartyStatus','Invalid_LNEntityType','Invalid_Percent');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_LNFaresID' => 2,'Invalid_SourceCode' => 3,'Invalid_Num' => 4,'Invalid_Char' => 5,'Invalid_RecType' => 6,'Invalid_PartyStatus' => 7,'Invalid_LNEntityType' => 8,'Invalid_Percent' => 9,0);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LNFaresID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'OADM0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_LNFaresID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'OADM0123456789'))));
EXPORT InValidMessageFT_Invalid_LNFaresID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('OADM0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SourceCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_SourceCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['OO','OP','SP','BP','SS','CO','CP','BB','CS','']);
EXPORT InValidMessageFT_Invalid_SourceCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('OO|OP|SP|BP|SS|CO|CP|BB|CS|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789. '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789. '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-0123456789. '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\'\\"\\\\,0123456789&() '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\'\\"\\\\,0123456789&() '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\'\\"\\\\,0123456789&() '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','D','H','P','U','F','R','M','G','']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|D|H|P|U|F|R|M|G|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_PartyStatus(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_PartyStatus(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['HW','DC','SI','MA','WF','']);
EXPORT InValidMessageFT_Invalid_PartyStatus(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('HW|DC|SI|MA|WF|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LNEntityType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LNEntityType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','B','T','I','']);
EXPORT InValidMessageFT_Invalid_LNEntityType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|B|T|I|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Percent(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.% '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Percent(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.% '))));
EXPORT InValidMessageFT_Invalid_Percent(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.% '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','vendor_source_flag','ln_fares_id','process_date','source_code','which_orig','conjunctive_name_seq','title','fname','mname','lname','name_suffix','cname','nameasis','append_prepaddr1','append_prepaddr2','append_rawaid','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone_number','name_type','prop_addr_propagated_ind','did','bdid','app_ssn','app_tax_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','ln_party_status','ln_percentage_ownership','ln_entity_type','ln_estate_trust_date','ln_goverment_type','xadl2_weight','addr_ind','best_addr_ind','addr_tx_id','best_addr_tx_id','location_id','best_locid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','vendor_source_flag','ln_fares_id','process_date','source_code','which_orig','conjunctive_name_seq','title','fname','mname','lname','name_suffix','cname','nameasis','append_prepaddr1','append_prepaddr2','append_rawaid','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone_number','name_type','prop_addr_propagated_ind','did','bdid','app_ssn','app_tax_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','ln_party_status','ln_percentage_ownership','ln_entity_type','ln_estate_trust_date','ln_goverment_type','xadl2_weight','addr_ind','best_addr_ind','addr_tx_id','best_addr_tx_id','location_id','best_locid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'vendor_source_flag' => 4,'ln_fares_id' => 5,'process_date' => 6,'source_code' => 7,'which_orig' => 8,'conjunctive_name_seq' => 9,'title' => 10,'fname' => 11,'mname' => 12,'lname' => 13,'name_suffix' => 14,'cname' => 15,'nameasis' => 16,'append_prepaddr1' => 17,'append_prepaddr2' => 18,'append_rawaid' => 19,'prim_range' => 20,'predir' => 21,'prim_name' => 22,'suffix' => 23,'postdir' => 24,'unit_desig' => 25,'sec_range' => 26,'p_city_name' => 27,'v_city_name' => 28,'st' => 29,'zip' => 30,'zip4' => 31,'cart' => 32,'cr_sort_sz' => 33,'lot' => 34,'lot_order' => 35,'dbpc' => 36,'chk_digit' => 37,'rec_type' => 38,'county' => 39,'geo_lat' => 40,'geo_long' => 41,'msa' => 42,'geo_blk' => 43,'geo_match' => 44,'err_stat' => 45,'phone_number' => 46,'name_type' => 47,'prop_addr_propagated_ind' => 48,'did' => 49,'bdid' => 50,'app_ssn' => 51,'app_tax_id' => 52,'dotid' => 53,'dotscore' => 54,'dotweight' => 55,'empid' => 56,'empscore' => 57,'empweight' => 58,'powid' => 59,'powscore' => 60,'powweight' => 61,'proxid' => 62,'proxscore' => 63,'proxweight' => 64,'seleid' => 65,'selescore' => 66,'seleweight' => 67,'orgid' => 68,'orgscore' => 69,'orgweight' => 70,'ultid' => 71,'ultscore' => 72,'ultweight' => 73,'source_rec_id' => 74,'ln_party_status' => 75,'ln_percentage_ownership' => 76,'ln_entity_type' => 77,'ln_estate_trust_date' => 78,'ln_goverment_type' => 79,'xadl2_weight' => 80,'addr_ind' => 81,'best_addr_ind' => 82,'addr_tx_id' => 83,'best_addr_tx_id' => 84,'location_id' => 85,'best_locid' => 86,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],[],[],['ALLOW'],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
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
 
EXPORT Make_vendor_source_flag(SALT311.StrType s0) := s0;
EXPORT InValid_vendor_source_flag(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor_source_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_fares_id(SALT311.StrType s0) := MakeFT_Invalid_LNFaresID(s0);
EXPORT InValid_ln_fares_id(SALT311.StrType s) := InValidFT_Invalid_LNFaresID(s);
EXPORT InValidMessage_ln_fares_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_LNFaresID(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_source_code(SALT311.StrType s0) := MakeFT_Invalid_SourceCode(s0);
EXPORT InValid_source_code(SALT311.StrType s) := InValidFT_Invalid_SourceCode(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_SourceCode(wh);
 
EXPORT Make_which_orig(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_which_orig(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_which_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_conjunctive_name_seq(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_conjunctive_name_seq(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_conjunctive_name_seq(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_cname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_nameasis(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_nameasis(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_nameasis(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_append_prepaddr1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_append_prepaddr1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_append_prepaddr1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_append_prepaddr2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_append_prepaddr2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_append_prepaddr2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_append_rawaid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_unit_desig(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_unit_desig(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_sec_range(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cart(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cart(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_cr_sort_sz(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cr_sort_sz(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lot(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_lot_order(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_lot_order(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dbpc(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dbpc(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_rec_type(SALT311.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rec_type(SALT311.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_blk(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_blk(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_geo_match(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_geo_match(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_phone_number(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_number(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_name_type(SALT311.StrType s0) := s0;
EXPORT InValid_name_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_propagated_ind(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_propagated_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_propagated_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_app_ssn(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_app_ssn(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_app_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_app_tax_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_app_tax_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_app_tax_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rec_id(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_source_rec_id(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ln_party_status(SALT311.StrType s0) := MakeFT_Invalid_PartyStatus(s0);
EXPORT InValid_ln_party_status(SALT311.StrType s) := InValidFT_Invalid_PartyStatus(s);
EXPORT InValidMessage_ln_party_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_PartyStatus(wh);
 
EXPORT Make_ln_percentage_ownership(SALT311.StrType s0) := MakeFT_Invalid_Percent(s0);
EXPORT InValid_ln_percentage_ownership(SALT311.StrType s) := InValidFT_Invalid_Percent(s);
EXPORT InValidMessage_ln_percentage_ownership(UNSIGNED1 wh) := InValidMessageFT_Invalid_Percent(wh);
 
EXPORT Make_ln_entity_type(SALT311.StrType s0) := MakeFT_Invalid_LNEntityType(s0);
EXPORT InValid_ln_entity_type(SALT311.StrType s) := InValidFT_Invalid_LNEntityType(s);
EXPORT InValidMessage_ln_entity_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_LNEntityType(wh);
 
EXPORT Make_ln_estate_trust_date(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_ln_estate_trust_date(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_ln_estate_trust_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ln_goverment_type(SALT311.StrType s0) := s0;
EXPORT InValid_ln_goverment_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_ln_goverment_type(UNSIGNED1 wh) := '';
 
EXPORT Make_xadl2_weight(SALT311.StrType s0) := s0;
EXPORT InValid_xadl2_weight(SALT311.StrType s) := 0;
EXPORT InValidMessage_xadl2_weight(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_ind(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_addr_ind(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_addr_ind(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_best_addr_ind(SALT311.StrType s0) := s0;
EXPORT InValid_best_addr_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_best_addr_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_tx_id(SALT311.StrType s0) := s0;
EXPORT InValid_addr_tx_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_tx_id(UNSIGNED1 wh) := '';
 
EXPORT Make_best_addr_tx_id(SALT311.StrType s0) := s0;
EXPORT InValid_best_addr_tx_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_best_addr_tx_id(UNSIGNED1 wh) := '';
 
EXPORT Make_location_id(SALT311.StrType s0) := s0;
EXPORT InValid_location_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_location_id(UNSIGNED1 wh) := '';
 
EXPORT Make_best_locid(SALT311.StrType s0) := s0;
EXPORT InValid_best_locid(SALT311.StrType s) := 0;
EXPORT InValidMessage_best_locid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LN_PropertyV2_Search;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_vendor_source_flag;
    BOOLEAN Diff_ln_fares_id;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_which_orig;
    BOOLEAN Diff_conjunctive_name_seq;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cname;
    BOOLEAN Diff_nameasis;
    BOOLEAN Diff_append_prepaddr1;
    BOOLEAN Diff_append_prepaddr2;
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
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
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_prop_addr_propagated_ind;
    BOOLEAN Diff_did;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_app_ssn;
    BOOLEAN Diff_app_tax_id;
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
    BOOLEAN Diff_ln_party_status;
    BOOLEAN Diff_ln_percentage_ownership;
    BOOLEAN Diff_ln_entity_type;
    BOOLEAN Diff_ln_estate_trust_date;
    BOOLEAN Diff_ln_goverment_type;
    BOOLEAN Diff_xadl2_weight;
    BOOLEAN Diff_addr_ind;
    BOOLEAN Diff_best_addr_ind;
    BOOLEAN Diff_addr_tx_id;
    BOOLEAN Diff_best_addr_tx_id;
    BOOLEAN Diff_location_id;
    BOOLEAN Diff_best_locid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_vendor_source_flag := le.vendor_source_flag <> ri.vendor_source_flag;
    SELF.Diff_ln_fares_id := le.ln_fares_id <> ri.ln_fares_id;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_which_orig := le.which_orig <> ri.which_orig;
    SELF.Diff_conjunctive_name_seq := le.conjunctive_name_seq <> ri.conjunctive_name_seq;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cname := le.cname <> ri.cname;
    SELF.Diff_nameasis := le.nameasis <> ri.nameasis;
    SELF.Diff_append_prepaddr1 := le.append_prepaddr1 <> ri.append_prepaddr1;
    SELF.Diff_append_prepaddr2 := le.append_prepaddr2 <> ri.append_prepaddr2;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
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
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_prop_addr_propagated_ind := le.prop_addr_propagated_ind <> ri.prop_addr_propagated_ind;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_app_ssn := le.app_ssn <> ri.app_ssn;
    SELF.Diff_app_tax_id := le.app_tax_id <> ri.app_tax_id;
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
    SELF.Diff_ln_party_status := le.ln_party_status <> ri.ln_party_status;
    SELF.Diff_ln_percentage_ownership := le.ln_percentage_ownership <> ri.ln_percentage_ownership;
    SELF.Diff_ln_entity_type := le.ln_entity_type <> ri.ln_entity_type;
    SELF.Diff_ln_estate_trust_date := le.ln_estate_trust_date <> ri.ln_estate_trust_date;
    SELF.Diff_ln_goverment_type := le.ln_goverment_type <> ri.ln_goverment_type;
    SELF.Diff_xadl2_weight := le.xadl2_weight <> ri.xadl2_weight;
    SELF.Diff_addr_ind := le.addr_ind <> ri.addr_ind;
    SELF.Diff_best_addr_ind := le.best_addr_ind <> ri.best_addr_ind;
    SELF.Diff_addr_tx_id := le.addr_tx_id <> ri.addr_tx_id;
    SELF.Diff_best_addr_tx_id := le.best_addr_tx_id <> ri.best_addr_tx_id;
    SELF.Diff_location_id := le.location_id <> ri.location_id;
    SELF.Diff_best_locid := le.best_locid <> ri.best_locid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_vendor_source_flag,1,0)+ IF( SELF.Diff_ln_fares_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_which_orig,1,0)+ IF( SELF.Diff_conjunctive_name_seq,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cname,1,0)+ IF( SELF.Diff_nameasis,1,0)+ IF( SELF.Diff_append_prepaddr1,1,0)+ IF( SELF.Diff_append_prepaddr2,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_prop_addr_propagated_ind,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_app_ssn,1,0)+ IF( SELF.Diff_app_tax_id,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_source_rec_id,1,0)+ IF( SELF.Diff_ln_party_status,1,0)+ IF( SELF.Diff_ln_percentage_ownership,1,0)+ IF( SELF.Diff_ln_entity_type,1,0)+ IF( SELF.Diff_ln_estate_trust_date,1,0)+ IF( SELF.Diff_ln_goverment_type,1,0)+ IF( SELF.Diff_xadl2_weight,1,0)+ IF( SELF.Diff_addr_ind,1,0)+ IF( SELF.Diff_best_addr_ind,1,0)+ IF( SELF.Diff_addr_tx_id,1,0)+ IF( SELF.Diff_best_addr_tx_id,1,0)+ IF( SELF.Diff_location_id,1,0)+ IF( SELF.Diff_best_locid,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_vendor_source_flag := COUNT(GROUP,%Closest%.Diff_vendor_source_flag);
    Count_Diff_ln_fares_id := COUNT(GROUP,%Closest%.Diff_ln_fares_id);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_which_orig := COUNT(GROUP,%Closest%.Diff_which_orig);
    Count_Diff_conjunctive_name_seq := COUNT(GROUP,%Closest%.Diff_conjunctive_name_seq);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cname := COUNT(GROUP,%Closest%.Diff_cname);
    Count_Diff_nameasis := COUNT(GROUP,%Closest%.Diff_nameasis);
    Count_Diff_append_prepaddr1 := COUNT(GROUP,%Closest%.Diff_append_prepaddr1);
    Count_Diff_append_prepaddr2 := COUNT(GROUP,%Closest%.Diff_append_prepaddr2);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
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
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_prop_addr_propagated_ind := COUNT(GROUP,%Closest%.Diff_prop_addr_propagated_ind);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_app_ssn := COUNT(GROUP,%Closest%.Diff_app_ssn);
    Count_Diff_app_tax_id := COUNT(GROUP,%Closest%.Diff_app_tax_id);
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
    Count_Diff_ln_party_status := COUNT(GROUP,%Closest%.Diff_ln_party_status);
    Count_Diff_ln_percentage_ownership := COUNT(GROUP,%Closest%.Diff_ln_percentage_ownership);
    Count_Diff_ln_entity_type := COUNT(GROUP,%Closest%.Diff_ln_entity_type);
    Count_Diff_ln_estate_trust_date := COUNT(GROUP,%Closest%.Diff_ln_estate_trust_date);
    Count_Diff_ln_goverment_type := COUNT(GROUP,%Closest%.Diff_ln_goverment_type);
    Count_Diff_xadl2_weight := COUNT(GROUP,%Closest%.Diff_xadl2_weight);
    Count_Diff_addr_ind := COUNT(GROUP,%Closest%.Diff_addr_ind);
    Count_Diff_best_addr_ind := COUNT(GROUP,%Closest%.Diff_best_addr_ind);
    Count_Diff_addr_tx_id := COUNT(GROUP,%Closest%.Diff_addr_tx_id);
    Count_Diff_best_addr_tx_id := COUNT(GROUP,%Closest%.Diff_best_addr_tx_id);
    Count_Diff_location_id := COUNT(GROUP,%Closest%.Diff_location_id);
    Count_Diff_best_locid := COUNT(GROUP,%Closest%.Diff_best_locid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
