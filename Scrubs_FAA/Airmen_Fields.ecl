IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Airmen_Fields := MODULE
 
EXPORT NumFields := 57;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Letter','Invalid_MedDate','Invalid_SSN','Invalid_Date','Invalid_Flag','Invalid_LetterCode','Invalid_MedClass','Invalid_AlphaNum');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Letter' => 2,'Invalid_MedDate' => 3,'Invalid_SSN' => 4,'Invalid_Date' => 5,'Invalid_Flag' => 6,'Invalid_LetterCode' => 7,'Invalid_MedClass' => 8,'Invalid_AlphaNum' => 9,0);
 
EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Letter(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Letter(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Letter(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_MedDate(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_MedDate(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_Invalid_MedDate(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,6'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('0,9'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Flag(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Flag(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['H','I','A']);
EXPORT InValidMessageFT_Invalid_Flag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('H|I|A'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_LetterCode(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_LetterCode(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','C']);
EXPORT InValidMessageFT_Invalid_LetterCode(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|C'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_MedClass(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_MedClass(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2','3','']);
EXPORT InValidMessageFT_Invalid_MedClass(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2|3|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'d_score','best_ssn','did_out','date_first_seen','date_last_seen','current_flag','record_type','letter_code','unique_id','orig_rec_type','orig_fname','orig_lname','street1','street2','city','state','zip_code','country','region','med_class','med_date','med_exp_date','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','oer','source');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'d_score','best_ssn','did_out','date_first_seen','date_last_seen','current_flag','record_type','letter_code','unique_id','orig_rec_type','orig_fname','orig_lname','street1','street2','city','state','zip_code','country','region','med_class','med_date','med_exp_date','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','oer','source');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'d_score' => 0,'best_ssn' => 1,'did_out' => 2,'date_first_seen' => 3,'date_last_seen' => 4,'current_flag' => 5,'record_type' => 6,'letter_code' => 7,'unique_id' => 8,'orig_rec_type' => 9,'orig_fname' => 10,'orig_lname' => 11,'street1' => 12,'street2' => 13,'city' => 14,'state' => 15,'zip_code' => 16,'country' => 17,'region' => 18,'med_class' => 19,'med_date' => 20,'med_exp_date' => 21,'prim_range' => 22,'predir' => 23,'prim_name' => 24,'suffix' => 25,'postdir' => 26,'unit_desig' => 27,'sec_range' => 28,'p_city_name' => 29,'v_city_name' => 30,'st' => 31,'zip' => 32,'zip4' => 33,'cart' => 34,'cr_sort_sz' => 35,'lot' => 36,'lot_order' => 37,'dpbc' => 38,'chk_digit' => 39,'rec_type' => 40,'ace_fips_st' => 41,'county' => 42,'county_name' => 43,'geo_lat' => 44,'geo_long' => 45,'msa' => 46,'geo_blk' => 47,'geo_match' => 48,'err_stat' => 49,'title' => 50,'fname' => 51,'mname' => 52,'lname' => 53,'name_suffix' => 54,'oer' => 55,'source' => 56,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW','LENGTH'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],[],['ENUM'],['ALLOW'],[],[],[],[],[],[],['ALLOW'],[],[],['ALLOW'],['ENUM'],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_d_score(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_d_score(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_d_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_best_ssn(SALT38.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_best_ssn(SALT38.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_did_out(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_did_out(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_did_out(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_date_first_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_first_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_last_seen(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_last_seen(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_current_flag(SALT38.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_current_flag(SALT38.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_current_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_record_type(SALT38.StrType s0) := s0;
EXPORT InValid_record_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_letter_code(SALT38.StrType s0) := MakeFT_Invalid_LetterCode(s0);
EXPORT InValid_letter_code(SALT38.StrType s) := InValidFT_Invalid_LetterCode(s);
EXPORT InValidMessage_letter_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_LetterCode(wh);
 
EXPORT Make_unique_id(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_unique_id(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_unique_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_orig_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_orig_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_fname(SALT38.StrType s0) := s0;
EXPORT InValid_orig_fname(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_lname(SALT38.StrType s0) := s0;
EXPORT InValid_orig_lname(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_street1(SALT38.StrType s0) := s0;
EXPORT InValid_street1(SALT38.StrType s) := 0;
EXPORT InValidMessage_street1(UNSIGNED1 wh) := '';
 
EXPORT Make_street2(SALT38.StrType s0) := s0;
EXPORT InValid_street2(SALT38.StrType s) := 0;
EXPORT InValidMessage_street2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT38.StrType s0) := s0;
EXPORT InValid_city(SALT38.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := s0;
EXPORT InValid_zip_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := '';
 
EXPORT Make_country(SALT38.StrType s0) := s0;
EXPORT InValid_country(SALT38.StrType s) := 0;
EXPORT InValidMessage_country(UNSIGNED1 wh) := '';
 
EXPORT Make_region(SALT38.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_region(SALT38.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_region(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_med_class(SALT38.StrType s0) := MakeFT_Invalid_MedClass(s0);
EXPORT InValid_med_class(SALT38.StrType s) := InValidFT_Invalid_MedClass(s);
EXPORT InValidMessage_med_class(UNSIGNED1 wh) := InValidMessageFT_Invalid_MedClass(wh);
 
EXPORT Make_med_date(SALT38.StrType s0) := MakeFT_Invalid_MedDate(s0);
EXPORT InValid_med_date(SALT38.StrType s) := InValidFT_Invalid_MedDate(s);
EXPORT InValidMessage_med_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_MedDate(wh);
 
EXPORT Make_med_exp_date(SALT38.StrType s0) := MakeFT_Invalid_MedDate(s0);
EXPORT InValid_med_exp_date(SALT38.StrType s) := InValidFT_Invalid_MedDate(s);
EXPORT InValidMessage_med_exp_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_MedDate(wh);
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := s0;
EXPORT InValid_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := s0;
EXPORT InValid_prim_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_dpbc(SALT38.StrType s0) := s0;
EXPORT InValid_dpbc(SALT38.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT38.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT38.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT38.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT38.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT38.StrType s0) := s0;
EXPORT InValid_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_county_name(SALT38.StrType s0) := s0;
EXPORT InValid_county_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_oer(SALT38.StrType s0) := s0;
EXPORT InValid_oer(SALT38.StrType s) := 0;
EXPORT InValidMessage_oer(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT38.StrType s0) := s0;
EXPORT InValid_source(SALT38.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_FAA;
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
    BOOLEAN Diff_d_score;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_did_out;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_current_flag;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_letter_code;
    BOOLEAN Diff_unique_id;
    BOOLEAN Diff_orig_rec_type;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_street1;
    BOOLEAN Diff_street2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_country;
    BOOLEAN Diff_region;
    BOOLEAN Diff_med_class;
    BOOLEAN Diff_med_date;
    BOOLEAN Diff_med_exp_date;
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
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_oer;
    BOOLEAN Diff_source;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_d_score := le.d_score <> ri.d_score;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_did_out := le.did_out <> ri.did_out;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_current_flag := le.current_flag <> ri.current_flag;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_letter_code := le.letter_code <> ri.letter_code;
    SELF.Diff_unique_id := le.unique_id <> ri.unique_id;
    SELF.Diff_orig_rec_type := le.orig_rec_type <> ri.orig_rec_type;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_street1 := le.street1 <> ri.street1;
    SELF.Diff_street2 := le.street2 <> ri.street2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_region := le.region <> ri.region;
    SELF.Diff_med_class := le.med_class <> ri.med_class;
    SELF.Diff_med_date := le.med_date <> ri.med_date;
    SELF.Diff_med_exp_date := le.med_exp_date <> ri.med_exp_date;
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
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_oer := le.oer <> ri.oer;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_d_score,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_did_out,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_current_flag,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_letter_code,1,0)+ IF( SELF.Diff_unique_id,1,0)+ IF( SELF.Diff_orig_rec_type,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_street1,1,0)+ IF( SELF.Diff_street2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_region,1,0)+ IF( SELF.Diff_med_class,1,0)+ IF( SELF.Diff_med_date,1,0)+ IF( SELF.Diff_med_exp_date,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_oer,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_d_score := COUNT(GROUP,%Closest%.Diff_d_score);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_did_out := COUNT(GROUP,%Closest%.Diff_did_out);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_current_flag := COUNT(GROUP,%Closest%.Diff_current_flag);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_letter_code := COUNT(GROUP,%Closest%.Diff_letter_code);
    Count_Diff_unique_id := COUNT(GROUP,%Closest%.Diff_unique_id);
    Count_Diff_orig_rec_type := COUNT(GROUP,%Closest%.Diff_orig_rec_type);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_street1 := COUNT(GROUP,%Closest%.Diff_street1);
    Count_Diff_street2 := COUNT(GROUP,%Closest%.Diff_street2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_region := COUNT(GROUP,%Closest%.Diff_region);
    Count_Diff_med_class := COUNT(GROUP,%Closest%.Diff_med_class);
    Count_Diff_med_date := COUNT(GROUP,%Closest%.Diff_med_date);
    Count_Diff_med_exp_date := COUNT(GROUP,%Closest%.Diff_med_exp_date);
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
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_oer := COUNT(GROUP,%Closest%.Diff_oer);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
