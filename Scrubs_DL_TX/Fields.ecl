IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_TX; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_boolean_yn_empty','invalid_wordbag','invalid_8pastdate','invalid_trans_indicator','invalid_card_type','invalid_dl_number','invalid_name','invalid_past_date','invalid_state','invalid_zip','invalid_zip4','invalid_date','invalid_name2','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_num_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_boolean_yn_empty' => 8,'invalid_wordbag' => 9,'invalid_8pastdate' => 10,'invalid_trans_indicator' => 11,'invalid_card_type' => 12,'invalid_dl_number' => 13,'invalid_name' => 14,'invalid_past_date' => 15,'invalid_state' => 16,'invalid_zip' => 17,'invalid_zip4' => 18,'invalid_date' => 19,'invalid_name2' => 20,'invalid_direction' => 21,'invalid_cart' => 22,'invalid_cr_sort_sz' => 23,'invalid_lot' => 24,'invalid_lot_order' => 25,'invalid_dpbc' => 26,'invalid_chk_digit' => 27,'invalid_record_type' => 28,'invalid_ace_fips_st' => 29,'invalid_fipscounty' => 30,'invalid_geo' => 31,'invalid_msa' => 32,'invalid_geo_blk' => 33,'invalid_geo_match' => 34,'invalid_err_stat' => 35,0);
 
EXPORT MakeFT_invalid_mandatory(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('1..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789 '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('0'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('N|Y|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%~'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,`./#@*\'\\|_"%~',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%~'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%~'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_trans_indicator(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_trans_indicator(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['D','U']);
EXPORT InValidMessageFT_invalid_trans_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('D|U'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_card_type(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_card_type(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['DL','ID']);
EXPORT InValidMessageFT_invalid_card_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('DL|ID'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_number(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_dl_number(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('10'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT35.StrType s,SALT35.StrType first_name,SALT35.StrType middle_name) := WHICH(~Scrubs_DL_TX.Functions.fn_valid_name(s,first_name,middle_name)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT35.StrType s) := WHICH(~Scrubs_DL_TX.Functions.fn_valid_past_date(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_valid_past_date'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(~Scrubs_DL_TX.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT35.StrType s) := WHICH(~Scrubs_DL_TX.Functions.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_valid_date'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name2(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name2(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := WHICH(~Scrubs_DL_TX.Functions.fn_valid_name(s,fname,mname)>0);
EXPORT InValidMessageFT_invalid_name2(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ENSW'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num(s1);
END;
EXPORT InValidFT_invalid_cart(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('A|B|C|D|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_lot(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'AD'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lot_order(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'AD'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('AD'),SALT35.HygieneErrors.NotLength('0,1'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_dpbc(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_chk_digit(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,1'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT35.StrType s) := WHICH(~Scrubs_DL_TX.Functions.fn_addr_rec_type(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TX.Functions.fn_addr_rec_type'),SALT35.HygieneErrors.NotLength('0,1,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_fips_st(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_ace_fips_st(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_ace_fips_st(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fipscounty(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_fipscounty(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_fipscounty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,3'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'-.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'-.0123456789'))));
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('-.0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_msa(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_geo_blk(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7));
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,7'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_geo_match(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,1'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num(s1);
END;
EXPORT InValidFT_invalid_err_stat(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','trans_indicator','card_type','dl_number','last_name','first_name','middle_name','suffix_name','date_of_birth','street_addr1','street_addr2','city','in_state','zip','in_zip4','issue_date','title','fname','mname','lname','suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'process_date' => 0,'trans_indicator' => 1,'card_type' => 2,'dl_number' => 3,'last_name' => 4,'first_name' => 5,'middle_name' => 6,'suffix_name' => 7,'date_of_birth' => 8,'street_addr1' => 9,'street_addr2' => 10,'city' => 11,'in_state' => 12,'zip' => 13,'in_zip4' => 14,'issue_date' => 15,'title' => 16,'fname' => 17,'mname' => 18,'lname' => 19,'suffix' => 20,'name_score' => 21,'prim_range' => 22,'predir' => 23,'prim_name' => 24,'addr_suffix' => 25,'postdir' => 26,'unit_desig' => 27,'sec_range' => 28,'p_city_name' => 29,'v_city_name' => 30,'state' => 31,'zip5' => 32,'zip4' => 33,'cart' => 34,'cr_sort_sz' => 35,'lot' => 36,'lot_order' => 37,'dpbc' => 38,'chk_digit' => 39,'rec_type' => 40,'ace_fips_st' => 41,'county' => 42,'geo_lat' => 43,'geo_long' => 44,'msa' => 45,'geo_blk' => 46,'geo_match' => 47,'err_stat' => 48,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_trans_indicator(SALT35.StrType s0) := MakeFT_invalid_trans_indicator(s0);
EXPORT InValid_trans_indicator(SALT35.StrType s) := InValidFT_invalid_trans_indicator(s);
EXPORT InValidMessage_trans_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_trans_indicator(wh);
 
EXPORT Make_card_type(SALT35.StrType s0) := MakeFT_invalid_card_type(s0);
EXPORT InValid_card_type(SALT35.StrType s) := InValidFT_invalid_card_type(s);
EXPORT InValidMessage_card_type(UNSIGNED1 wh) := InValidMessageFT_invalid_card_type(wh);
 
EXPORT Make_dl_number(SALT35.StrType s0) := MakeFT_invalid_dl_number(s0);
EXPORT InValid_dl_number(SALT35.StrType s) := InValidFT_invalid_dl_number(s);
EXPORT InValidMessage_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_number(wh);
 
EXPORT Make_last_name(SALT35.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_last_name(SALT35.StrType s,SALT35.StrType first_name,SALT35.StrType middle_name) := InValidFT_invalid_name(s,first_name,middle_name);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_first_name(SALT35.StrType s0) := s0;
EXPORT InValid_first_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_middle_name(SALT35.StrType s0) := s0;
EXPORT InValid_middle_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix_name(SALT35.StrType s0) := s0;
EXPORT InValid_suffix_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_suffix_name(UNSIGNED1 wh) := '';
 
EXPORT Make_date_of_birth(SALT35.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_date_of_birth(SALT35.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_street_addr1(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_street_addr1(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_street_addr1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_street_addr2(SALT35.StrType s0) := s0;
EXPORT InValid_street_addr2(SALT35.StrType s) := 0;
EXPORT InValidMessage_street_addr2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT35.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_city(SALT35.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_in_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_in_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_in_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT35.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT35.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_in_zip4(SALT35.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_in_zip4(SALT35.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_in_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_issue_date(SALT35.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_issue_date(SALT35.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_title(SALT35.StrType s0) := s0;
EXPORT InValid_title(SALT35.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT35.StrType s0) := s0;
EXPORT InValid_fname(SALT35.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT35.StrType s0) := s0;
EXPORT InValid_mname(SALT35.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT35.StrType s0) := MakeFT_invalid_name2(s0);
EXPORT InValid_lname(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := InValidFT_invalid_name2(s,fname,mname);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name2(wh);
 
EXPORT Make_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_name_score(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_p_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_v_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_v_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip5(SALT35.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip5(SALT35.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT35.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT35.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT35.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT35.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT35.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT35.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT35.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT35.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_lot_order(SALT35.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT35.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_dpbc(SALT35.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dpbc(SALT35.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_chk_digit(SALT35.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT35.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_rec_type(SALT35.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_rec_type(SALT35.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_ace_fips_st(SALT35.StrType s0) := MakeFT_invalid_ace_fips_st(s0);
EXPORT InValid_ace_fips_st(SALT35.StrType s) := InValidFT_invalid_ace_fips_st(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_fips_st(wh);
 
EXPORT Make_county(SALT35.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_county(SALT35.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
 
EXPORT Make_geo_lat(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_long(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_msa(SALT35.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT35.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_geo_blk(SALT35.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_geo_blk(SALT35.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_geo_match(SALT35.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT35.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_err_stat(SALT35.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT35.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_TX;
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
    BOOLEAN Diff_trans_indicator;
    BOOLEAN Diff_card_type;
    BOOLEAN Diff_dl_number;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_suffix_name;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_street_addr1;
    BOOLEAN Diff_street_addr2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_in_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_in_zip4;
    BOOLEAN Diff_issue_date;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
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
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_trans_indicator := le.trans_indicator <> ri.trans_indicator;
    SELF.Diff_card_type := le.card_type <> ri.card_type;
    SELF.Diff_dl_number := le.dl_number <> ri.dl_number;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_suffix_name := le.suffix_name <> ri.suffix_name;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_street_addr1 := le.street_addr1 <> ri.street_addr1;
    SELF.Diff_street_addr2 := le.street_addr2 <> ri.street_addr2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_in_state := le.in_state <> ri.in_state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_in_zip4 := le.in_zip4 <> ri.in_zip4;
    SELF.Diff_issue_date := le.issue_date <> ri.issue_date;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
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
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_trans_indicator,1,0)+ IF( SELF.Diff_card_type,1,0)+ IF( SELF.Diff_dl_number,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_suffix_name,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_street_addr1,1,0)+ IF( SELF.Diff_street_addr2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_in_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_in_zip4,1,0)+ IF( SELF.Diff_issue_date,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_trans_indicator := COUNT(GROUP,%Closest%.Diff_trans_indicator);
    Count_Diff_card_type := COUNT(GROUP,%Closest%.Diff_card_type);
    Count_Diff_dl_number := COUNT(GROUP,%Closest%.Diff_dl_number);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_suffix_name := COUNT(GROUP,%Closest%.Diff_suffix_name);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_street_addr1 := COUNT(GROUP,%Closest%.Diff_street_addr1);
    Count_Diff_street_addr2 := COUNT(GROUP,%Closest%.Diff_street_addr2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_in_state := COUNT(GROUP,%Closest%.Diff_in_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_in_zip4 := COUNT(GROUP,%Closest%.Diff_in_zip4);
    Count_Diff_issue_date := COUNT(GROUP,%Closest%.Diff_issue_date);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
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
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
