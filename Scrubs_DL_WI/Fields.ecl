IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_WI; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_blank','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_boolean_yn_empty','invalid_wordbag','invalid_8pastdate','invalid_8generaldate','invalid_orig_dl_number','invalid_orig_name','invalid_orig_sex','invalid_state','invalid_orig_zip_code','invalid_orig_opt_out_code','invalid_orig_license_counter','invalid_append_license_type','invalid_append_classes','invalid_append_endorsements','invalid_clean_name','invalid_direction','invalid_zip_code5','invalid_zip_code4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_blank' => 3,'invalid_alpha_num_specials' => 4,'invalid_numeric' => 5,'invalid_numeric_blank' => 6,'invalid_alpha_num' => 7,'invalid_empty' => 8,'invalid_boolean_yn_empty' => 9,'invalid_wordbag' => 10,'invalid_8pastdate' => 11,'invalid_8generaldate' => 12,'invalid_orig_dl_number' => 13,'invalid_orig_name' => 14,'invalid_orig_sex' => 15,'invalid_state' => 16,'invalid_orig_zip_code' => 17,'invalid_orig_opt_out_code' => 18,'invalid_orig_license_counter' => 19,'invalid_append_license_type' => 20,'invalid_append_classes' => 21,'invalid_append_endorsements' => 22,'invalid_clean_name' => 23,'invalid_direction' => 24,'invalid_zip_code5' => 25,'invalid_zip_code4' => 26,'invalid_cart' => 27,'invalid_cr_sort_sz' => 28,'invalid_lot' => 29,'invalid_lot_order' => 30,'invalid_dpbc' => 31,'invalid_chk_digit' => 32,'invalid_record_type' => 33,'invalid_ace_fips_st' => 34,'invalid_fipscounty' => 35,'invalid_geo' => 36,'invalid_msa' => 37,'invalid_geo_blk' => 38,'invalid_geo_match' => 39,'invalid_err_stat' => 40,0);
 
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
 
EXPORT MakeFT_invalid_alpha_blank(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_blank(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\'#/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\'#/'))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\'#/'),SALT35.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_8generaldate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8generaldate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dl_number(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_dl_number(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 14));
EXPORT InValidMessageFT_invalid_orig_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_check_dl_number'),SALT35.HygieneErrors.NotLength('14'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_name(SALT35.StrType s,SALT35.StrType orig_first_name,SALT35.StrType orig_middle_initial) := WHICH(~Scrubs_DL_WI.Functions.fn_valid_name(s,orig_first_name,orig_middle_initial)>0);
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_sex(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_sex(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['M','F','']);
EXPORT InValidMessageFT_invalid_orig_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('M|F|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip_code(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_orig_zip_code(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_orig_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('5,9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_opt_out_code(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_opt_out_code(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['S','N']);
EXPORT InValidMessageFT_invalid_orig_opt_out_code(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('S|N'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_license_counter(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_license_counter(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['1','2','3','4','5','6']);
EXPORT InValidMessageFT_invalid_orig_license_counter(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('1|2|3|4|5|6'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_append_license_type(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_license_type(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_lic_type(s)>0);
EXPORT InValidMessageFT_invalid_append_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_lic_type'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_append_classes(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_classes(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_check_lic_class(s)>0);
EXPORT InValidMessageFT_invalid_append_classes(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_check_lic_class'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_append_endorsements(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_endorsements(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_check_endorsements(s)>0);
EXPORT InValidMessageFT_invalid_append_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_check_endorsements'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT35.StrType s,SALT35.StrType clean_name_first,SALT35.StrType clean_name_middle) := WHICH(~Scrubs_DL_WI.Functions.fn_valid_name(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ENSW'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code5(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip_code5(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip_code5(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip_code4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_record_type(SALT35.StrType s) := WHICH(~Scrubs_DL_WI.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_WI.Functions.fn_addr_rec_type'),SALT35.HygieneErrors.Good);
 
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
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_dl_number','orig_last_name','orig_first_name','orig_middle_initial','orig_sex','orig_dob','orig_city','orig_address1','orig_address2','append_po_box','orig_county_name','orig_state','orig_zip_code','orig_opt_out_code','orig_license_counter','append_license_type','append_classes','append_endorsements','append_issue_date','append_expiration_date','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'append_process_date' => 0,'orig_dl_number' => 1,'orig_last_name' => 2,'orig_first_name' => 3,'orig_middle_initial' => 4,'orig_sex' => 5,'orig_dob' => 6,'orig_city' => 7,'orig_address1' => 8,'orig_address2' => 9,'append_po_box' => 10,'orig_county_name' => 11,'orig_state' => 12,'orig_zip_code' => 13,'orig_opt_out_code' => 14,'orig_license_counter' => 15,'append_license_type' => 16,'append_classes' => 17,'append_endorsements' => 18,'append_issue_date' => 19,'append_expiration_date' => 20,'clean_name_prefix' => 21,'clean_name_first' => 22,'clean_name_middle' => 23,'clean_name_last' => 24,'clean_name_suffix' => 25,'clean_name_score' => 26,'clean_prim_range' => 27,'clean_predir' => 28,'clean_prim_name' => 29,'clean_addr_suffix' => 30,'clean_postdir' => 31,'clean_unit_desig' => 32,'clean_sec_range' => 33,'clean_p_city_name' => 34,'clean_v_city_name' => 35,'clean_st' => 36,'clean_zip' => 37,'clean_zip4' => 38,'clean_cart' => 39,'clean_cr_sort_sz' => 40,'clean_lot' => 41,'clean_lot_order' => 42,'clean_dpbc' => 43,'clean_chk_digit' => 44,'clean_record_type' => 45,'clean_ace_fips_st' => 46,'clean_fipscounty' => 47,'clean_geo_lat' => 48,'clean_geo_long' => 49,'clean_msa' => 50,'clean_geo_blk' => 51,'clean_geo_match' => 52,'clean_err_stat' => 53,0);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_append_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_dl_number(SALT35.StrType s0) := MakeFT_invalid_orig_dl_number(s0);
EXPORT InValid_orig_dl_number(SALT35.StrType s) := InValidFT_invalid_orig_dl_number(s);
EXPORT InValidMessage_orig_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dl_number(wh);
 
EXPORT Make_orig_last_name(SALT35.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_last_name(SALT35.StrType s,SALT35.StrType orig_first_name,SALT35.StrType orig_middle_initial) := InValidFT_invalid_orig_name(s,orig_first_name,orig_middle_initial);
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_first_name(SALT35.StrType s0) := s0;
EXPORT InValid_orig_first_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_middle_initial(SALT35.StrType s0) := s0;
EXPORT InValid_orig_middle_initial(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_middle_initial(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_sex(SALT35.StrType s0) := MakeFT_invalid_orig_sex(s0);
EXPORT InValid_orig_sex(SALT35.StrType s) := InValidFT_invalid_orig_sex(s);
EXPORT InValidMessage_orig_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_sex(wh);
 
EXPORT Make_orig_dob(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_orig_dob(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_city(SALT35.StrType s0) := MakeFT_invalid_alpha_blank(s0);
EXPORT InValid_orig_city(SALT35.StrType s) := InValidFT_invalid_alpha_blank(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank(wh);
 
EXPORT Make_orig_address1(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_address1(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_address2(SALT35.StrType s0) := s0;
EXPORT InValid_orig_address2(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_append_po_box(SALT35.StrType s0) := s0;
EXPORT InValid_append_po_box(SALT35.StrType s) := 0;
EXPORT InValidMessage_append_po_box(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_county_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_orig_county_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_orig_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_orig_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_zip_code(SALT35.StrType s0) := MakeFT_invalid_orig_zip_code(s0);
EXPORT InValid_orig_zip_code(SALT35.StrType s) := InValidFT_invalid_orig_zip_code(s);
EXPORT InValidMessage_orig_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip_code(wh);
 
EXPORT Make_orig_opt_out_code(SALT35.StrType s0) := MakeFT_invalid_orig_opt_out_code(s0);
EXPORT InValid_orig_opt_out_code(SALT35.StrType s) := InValidFT_invalid_orig_opt_out_code(s);
EXPORT InValidMessage_orig_opt_out_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_opt_out_code(wh);
 
EXPORT Make_orig_license_counter(SALT35.StrType s0) := MakeFT_invalid_orig_license_counter(s0);
EXPORT InValid_orig_license_counter(SALT35.StrType s) := InValidFT_invalid_orig_license_counter(s);
EXPORT InValidMessage_orig_license_counter(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_license_counter(wh);
 
EXPORT Make_append_license_type(SALT35.StrType s0) := MakeFT_invalid_append_license_type(s0);
EXPORT InValid_append_license_type(SALT35.StrType s) := InValidFT_invalid_append_license_type(s);
EXPORT InValidMessage_append_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_append_license_type(wh);
 
EXPORT Make_append_classes(SALT35.StrType s0) := MakeFT_invalid_append_classes(s0);
EXPORT InValid_append_classes(SALT35.StrType s) := InValidFT_invalid_append_classes(s);
EXPORT InValidMessage_append_classes(UNSIGNED1 wh) := InValidMessageFT_invalid_append_classes(wh);
 
EXPORT Make_append_endorsements(SALT35.StrType s0) := MakeFT_invalid_append_endorsements(s0);
EXPORT InValid_append_endorsements(SALT35.StrType s) := InValidFT_invalid_append_endorsements(s);
EXPORT InValidMessage_append_endorsements(UNSIGNED1 wh) := InValidMessageFT_invalid_append_endorsements(wh);
 
EXPORT Make_append_issue_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_append_issue_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_append_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_append_expiration_date(SALT35.StrType s0) := MakeFT_invalid_8generaldate(s0);
EXPORT InValid_append_expiration_date(SALT35.StrType s) := InValidFT_invalid_8generaldate(s);
EXPORT InValidMessage_append_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8generaldate(wh);
 
EXPORT Make_clean_name_prefix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_first(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_middle(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_middle(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_last(SALT35.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_name_last(SALT35.StrType s,SALT35.StrType clean_name_first,SALT35.StrType clean_name_middle) := InValidFT_invalid_clean_name(s,clean_name_first,clean_name_middle);
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_clean_name_score(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_clean_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_prim_name(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_prim_name(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_postdir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_postdir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_clean_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_blank(s0);
EXPORT InValid_clean_p_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_blank(s);
EXPORT InValidMessage_clean_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank(wh);
 
EXPORT Make_clean_v_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_blank(s0);
EXPORT InValid_clean_v_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_blank(s);
EXPORT InValidMessage_clean_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_blank(wh);
 
EXPORT Make_clean_st(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_clean_st(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_clean_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_clean_zip(SALT35.StrType s0) := MakeFT_invalid_zip_code5(s0);
EXPORT InValid_clean_zip(SALT35.StrType s) := InValidFT_invalid_zip_code5(s);
EXPORT InValidMessage_clean_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code5(wh);
 
EXPORT Make_clean_zip4(SALT35.StrType s0) := MakeFT_invalid_zip_code4(s0);
EXPORT InValid_clean_zip4(SALT35.StrType s) := InValidFT_invalid_zip_code4(s);
EXPORT InValidMessage_clean_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code4(wh);
 
EXPORT Make_clean_cart(SALT35.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_clean_cart(SALT35.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_clean_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_clean_cr_sort_sz(SALT35.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_clean_cr_sort_sz(SALT35.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_clean_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_clean_lot(SALT35.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_clean_lot(SALT35.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_clean_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_clean_lot_order(SALT35.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_clean_lot_order(SALT35.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_clean_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_clean_dpbc(SALT35.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_clean_dpbc(SALT35.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_clean_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_clean_chk_digit(SALT35.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_clean_chk_digit(SALT35.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_clean_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_clean_record_type(SALT35.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_clean_record_type(SALT35.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_clean_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_clean_ace_fips_st(SALT35.StrType s0) := MakeFT_invalid_ace_fips_st(s0);
EXPORT InValid_clean_ace_fips_st(SALT35.StrType s) := InValidFT_invalid_ace_fips_st(s);
EXPORT InValidMessage_clean_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_fips_st(wh);
 
EXPORT Make_clean_fipscounty(SALT35.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_clean_fipscounty(SALT35.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_clean_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
 
EXPORT Make_clean_geo_lat(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_geo_lat(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_geo_long(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_geo_long(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_msa(SALT35.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_clean_msa(SALT35.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_clean_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_clean_geo_blk(SALT35.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_clean_geo_blk(SALT35.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_clean_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_clean_geo_match(SALT35.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_clean_geo_match(SALT35.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_clean_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_clean_err_stat(SALT35.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_clean_err_stat(SALT35.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_clean_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_WI;
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
    BOOLEAN Diff_append_process_date;
    BOOLEAN Diff_orig_dl_number;
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_initial;
    BOOLEAN Diff_orig_sex;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_address1;
    BOOLEAN Diff_orig_address2;
    BOOLEAN Diff_append_po_box;
    BOOLEAN Diff_orig_county_name;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip_code;
    BOOLEAN Diff_orig_opt_out_code;
    BOOLEAN Diff_orig_license_counter;
    BOOLEAN Diff_append_license_type;
    BOOLEAN Diff_append_classes;
    BOOLEAN Diff_append_endorsements;
    BOOLEAN Diff_append_issue_date;
    BOOLEAN Diff_append_expiration_date;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    BOOLEAN Diff_clean_prim_range;
    BOOLEAN Diff_clean_predir;
    BOOLEAN Diff_clean_prim_name;
    BOOLEAN Diff_clean_addr_suffix;
    BOOLEAN Diff_clean_postdir;
    BOOLEAN Diff_clean_unit_desig;
    BOOLEAN Diff_clean_sec_range;
    BOOLEAN Diff_clean_p_city_name;
    BOOLEAN Diff_clean_v_city_name;
    BOOLEAN Diff_clean_st;
    BOOLEAN Diff_clean_zip;
    BOOLEAN Diff_clean_zip4;
    BOOLEAN Diff_clean_cart;
    BOOLEAN Diff_clean_cr_sort_sz;
    BOOLEAN Diff_clean_lot;
    BOOLEAN Diff_clean_lot_order;
    BOOLEAN Diff_clean_dpbc;
    BOOLEAN Diff_clean_chk_digit;
    BOOLEAN Diff_clean_record_type;
    BOOLEAN Diff_clean_ace_fips_st;
    BOOLEAN Diff_clean_fipscounty;
    BOOLEAN Diff_clean_geo_lat;
    BOOLEAN Diff_clean_geo_long;
    BOOLEAN Diff_clean_msa;
    BOOLEAN Diff_clean_geo_blk;
    BOOLEAN Diff_clean_geo_match;
    BOOLEAN Diff_clean_err_stat;
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_orig_dl_number := le.orig_dl_number <> ri.orig_dl_number;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_initial := le.orig_middle_initial <> ri.orig_middle_initial;
    SELF.Diff_orig_sex := le.orig_sex <> ri.orig_sex;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_address1 := le.orig_address1 <> ri.orig_address1;
    SELF.Diff_orig_address2 := le.orig_address2 <> ri.orig_address2;
    SELF.Diff_append_po_box := le.append_po_box <> ri.append_po_box;
    SELF.Diff_orig_county_name := le.orig_county_name <> ri.orig_county_name;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip_code := le.orig_zip_code <> ri.orig_zip_code;
    SELF.Diff_orig_opt_out_code := le.orig_opt_out_code <> ri.orig_opt_out_code;
    SELF.Diff_orig_license_counter := le.orig_license_counter <> ri.orig_license_counter;
    SELF.Diff_append_license_type := le.append_license_type <> ri.append_license_type;
    SELF.Diff_append_classes := le.append_classes <> ri.append_classes;
    SELF.Diff_append_endorsements := le.append_endorsements <> ri.append_endorsements;
    SELF.Diff_append_issue_date := le.append_issue_date <> ri.append_issue_date;
    SELF.Diff_append_expiration_date := le.append_expiration_date <> ri.append_expiration_date;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Diff_clean_prim_range := le.clean_prim_range <> ri.clean_prim_range;
    SELF.Diff_clean_predir := le.clean_predir <> ri.clean_predir;
    SELF.Diff_clean_prim_name := le.clean_prim_name <> ri.clean_prim_name;
    SELF.Diff_clean_addr_suffix := le.clean_addr_suffix <> ri.clean_addr_suffix;
    SELF.Diff_clean_postdir := le.clean_postdir <> ri.clean_postdir;
    SELF.Diff_clean_unit_desig := le.clean_unit_desig <> ri.clean_unit_desig;
    SELF.Diff_clean_sec_range := le.clean_sec_range <> ri.clean_sec_range;
    SELF.Diff_clean_p_city_name := le.clean_p_city_name <> ri.clean_p_city_name;
    SELF.Diff_clean_v_city_name := le.clean_v_city_name <> ri.clean_v_city_name;
    SELF.Diff_clean_st := le.clean_st <> ri.clean_st;
    SELF.Diff_clean_zip := le.clean_zip <> ri.clean_zip;
    SELF.Diff_clean_zip4 := le.clean_zip4 <> ri.clean_zip4;
    SELF.Diff_clean_cart := le.clean_cart <> ri.clean_cart;
    SELF.Diff_clean_cr_sort_sz := le.clean_cr_sort_sz <> ri.clean_cr_sort_sz;
    SELF.Diff_clean_lot := le.clean_lot <> ri.clean_lot;
    SELF.Diff_clean_lot_order := le.clean_lot_order <> ri.clean_lot_order;
    SELF.Diff_clean_dpbc := le.clean_dpbc <> ri.clean_dpbc;
    SELF.Diff_clean_chk_digit := le.clean_chk_digit <> ri.clean_chk_digit;
    SELF.Diff_clean_record_type := le.clean_record_type <> ri.clean_record_type;
    SELF.Diff_clean_ace_fips_st := le.clean_ace_fips_st <> ri.clean_ace_fips_st;
    SELF.Diff_clean_fipscounty := le.clean_fipscounty <> ri.clean_fipscounty;
    SELF.Diff_clean_geo_lat := le.clean_geo_lat <> ri.clean_geo_lat;
    SELF.Diff_clean_geo_long := le.clean_geo_long <> ri.clean_geo_long;
    SELF.Diff_clean_msa := le.clean_msa <> ri.clean_msa;
    SELF.Diff_clean_geo_blk := le.clean_geo_blk <> ri.clean_geo_blk;
    SELF.Diff_clean_geo_match := le.clean_geo_match <> ri.clean_geo_match;
    SELF.Diff_clean_err_stat := le.clean_err_stat <> ri.clean_err_stat;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_orig_dl_number,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_initial,1,0)+ IF( SELF.Diff_orig_sex,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_address1,1,0)+ IF( SELF.Diff_orig_address2,1,0)+ IF( SELF.Diff_append_po_box,1,0)+ IF( SELF.Diff_orig_county_name,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip_code,1,0)+ IF( SELF.Diff_orig_opt_out_code,1,0)+ IF( SELF.Diff_orig_license_counter,1,0)+ IF( SELF.Diff_append_license_type,1,0)+ IF( SELF.Diff_append_classes,1,0)+ IF( SELF.Diff_append_endorsements,1,0)+ IF( SELF.Diff_append_issue_date,1,0)+ IF( SELF.Diff_append_expiration_date,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_clean_prim_range,1,0)+ IF( SELF.Diff_clean_predir,1,0)+ IF( SELF.Diff_clean_prim_name,1,0)+ IF( SELF.Diff_clean_addr_suffix,1,0)+ IF( SELF.Diff_clean_postdir,1,0)+ IF( SELF.Diff_clean_unit_desig,1,0)+ IF( SELF.Diff_clean_sec_range,1,0)+ IF( SELF.Diff_clean_p_city_name,1,0)+ IF( SELF.Diff_clean_v_city_name,1,0)+ IF( SELF.Diff_clean_st,1,0)+ IF( SELF.Diff_clean_zip,1,0)+ IF( SELF.Diff_clean_zip4,1,0)+ IF( SELF.Diff_clean_cart,1,0)+ IF( SELF.Diff_clean_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_lot,1,0)+ IF( SELF.Diff_clean_lot_order,1,0)+ IF( SELF.Diff_clean_dpbc,1,0)+ IF( SELF.Diff_clean_chk_digit,1,0)+ IF( SELF.Diff_clean_record_type,1,0)+ IF( SELF.Diff_clean_ace_fips_st,1,0)+ IF( SELF.Diff_clean_fipscounty,1,0)+ IF( SELF.Diff_clean_geo_lat,1,0)+ IF( SELF.Diff_clean_geo_long,1,0)+ IF( SELF.Diff_clean_msa,1,0)+ IF( SELF.Diff_clean_geo_blk,1,0)+ IF( SELF.Diff_clean_geo_match,1,0)+ IF( SELF.Diff_clean_err_stat,1,0);
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
    Count_Diff_append_process_date := COUNT(GROUP,%Closest%.Diff_append_process_date);
    Count_Diff_orig_dl_number := COUNT(GROUP,%Closest%.Diff_orig_dl_number);
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_initial := COUNT(GROUP,%Closest%.Diff_orig_middle_initial);
    Count_Diff_orig_sex := COUNT(GROUP,%Closest%.Diff_orig_sex);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_address1 := COUNT(GROUP,%Closest%.Diff_orig_address1);
    Count_Diff_orig_address2 := COUNT(GROUP,%Closest%.Diff_orig_address2);
    Count_Diff_append_po_box := COUNT(GROUP,%Closest%.Diff_append_po_box);
    Count_Diff_orig_county_name := COUNT(GROUP,%Closest%.Diff_orig_county_name);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip_code := COUNT(GROUP,%Closest%.Diff_orig_zip_code);
    Count_Diff_orig_opt_out_code := COUNT(GROUP,%Closest%.Diff_orig_opt_out_code);
    Count_Diff_orig_license_counter := COUNT(GROUP,%Closest%.Diff_orig_license_counter);
    Count_Diff_append_license_type := COUNT(GROUP,%Closest%.Diff_append_license_type);
    Count_Diff_append_classes := COUNT(GROUP,%Closest%.Diff_append_classes);
    Count_Diff_append_endorsements := COUNT(GROUP,%Closest%.Diff_append_endorsements);
    Count_Diff_append_issue_date := COUNT(GROUP,%Closest%.Diff_append_issue_date);
    Count_Diff_append_expiration_date := COUNT(GROUP,%Closest%.Diff_append_expiration_date);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
    Count_Diff_clean_prim_range := COUNT(GROUP,%Closest%.Diff_clean_prim_range);
    Count_Diff_clean_predir := COUNT(GROUP,%Closest%.Diff_clean_predir);
    Count_Diff_clean_prim_name := COUNT(GROUP,%Closest%.Diff_clean_prim_name);
    Count_Diff_clean_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_addr_suffix);
    Count_Diff_clean_postdir := COUNT(GROUP,%Closest%.Diff_clean_postdir);
    Count_Diff_clean_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_unit_desig);
    Count_Diff_clean_sec_range := COUNT(GROUP,%Closest%.Diff_clean_sec_range);
    Count_Diff_clean_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_p_city_name);
    Count_Diff_clean_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_v_city_name);
    Count_Diff_clean_st := COUNT(GROUP,%Closest%.Diff_clean_st);
    Count_Diff_clean_zip := COUNT(GROUP,%Closest%.Diff_clean_zip);
    Count_Diff_clean_zip4 := COUNT(GROUP,%Closest%.Diff_clean_zip4);
    Count_Diff_clean_cart := COUNT(GROUP,%Closest%.Diff_clean_cart);
    Count_Diff_clean_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_cr_sort_sz);
    Count_Diff_clean_lot := COUNT(GROUP,%Closest%.Diff_clean_lot);
    Count_Diff_clean_lot_order := COUNT(GROUP,%Closest%.Diff_clean_lot_order);
    Count_Diff_clean_dpbc := COUNT(GROUP,%Closest%.Diff_clean_dpbc);
    Count_Diff_clean_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_chk_digit);
    Count_Diff_clean_record_type := COUNT(GROUP,%Closest%.Diff_clean_record_type);
    Count_Diff_clean_ace_fips_st := COUNT(GROUP,%Closest%.Diff_clean_ace_fips_st);
    Count_Diff_clean_fipscounty := COUNT(GROUP,%Closest%.Diff_clean_fipscounty);
    Count_Diff_clean_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_geo_lat);
    Count_Diff_clean_geo_long := COUNT(GROUP,%Closest%.Diff_clean_geo_long);
    Count_Diff_clean_msa := COUNT(GROUP,%Closest%.Diff_clean_msa);
    Count_Diff_clean_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_geo_blk);
    Count_Diff_clean_geo_match := COUNT(GROUP,%Closest%.Diff_clean_geo_match);
    Count_Diff_clean_err_stat := COUNT(GROUP,%Closest%.Diff_clean_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
