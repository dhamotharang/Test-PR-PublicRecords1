IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NE; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_wordbag','invalid_8pastdate','invalid_dln','invalid_state','invalid_zip5','invalid_zip4','invalid_gender','invalid_height','invalid_weight','invalid_eye_color','invalid_hair_color','invalid_license_type','invalid_name','invalid_direction','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_wordbag' => 8,'invalid_8pastdate' => 9,'invalid_dln' => 10,'invalid_state' => 11,'invalid_zip5' => 12,'invalid_zip4' => 13,'invalid_gender' => 14,'invalid_height' => 15,'invalid_weight' => 16,'invalid_eye_color' => 17,'invalid_hair_color' => 18,'invalid_license_type' => 19,'invalid_name' => 20,'invalid_direction' => 21,'invalid_cart' => 22,'invalid_cr_sort_sz' => 23,'invalid_lot' => 24,'invalid_lot_order' => 25,'invalid_dpbc' => 26,'invalid_chk_digit' => 27,'invalid_record_type' => 28,'invalid_ace_fips_st' => 29,'invalid_fipscounty' => 30,'invalid_geo' => 31,'invalid_msa' => 32,'invalid_geo_blk' => 33,'invalid_geo_match' => 34,'invalid_err_stat' => 35,0);
 
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
 
EXPORT MakeFT_invalid_alpha_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'))));
EXPORT InValidMessageFT_invalid_alpha_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'),SALT35.HygieneErrors.Good);
 
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
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('0'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=!+&,./#*\'\\|"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dln(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dln(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_dln(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_check_dl_number'),SALT35.HygieneErrors.NotLength('9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip5(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['F','M']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('F|M'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_height(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_height(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_verify_height(s)>0,~(LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_height(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_verify_height'),SALT35.HygieneErrors.NotLength('3'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_weight(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_weight(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_verify_weight(s)>0,~(LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_weight(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_verify_weight'),SALT35.HygieneErrors.NotLength('3'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_eye_color(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_eye_color(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_check_eye_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hair_color(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hair_color(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_check_hair_color(s)>0);
EXPORT InValidMessageFT_invalid_hair_color(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_check_hair_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_type(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_type(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_check_license_type(s)>0);
EXPORT InValidMessageFT_invalid_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_check_license_type'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=!+&,./#*\'\\|"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_name(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'))),~Scrubs_DL_NE.Functions.fn_valid_name(s,fname,mname)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ENSW'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num(s1);
END;
EXPORT InValidFT_invalid_cart(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['A','B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('A|B|C|D|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric_blank(s1);
END;
EXPORT InValidFT_invalid_lot(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789 '),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_record_type(SALT35.StrType s) := WHICH(~Scrubs_DL_NE.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NE.Functions.fn_addr_rec_type'),SALT35.HygieneErrors.Good);
 
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
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num(s1);
END;
EXPORT InValidFT_invalid_err_stat(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','dln','name','dob','address_street','address_city','address_state','address_zip5','address_zip4','gender','height','weight','eye_color','hair_color','license_type','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'process_date' => 0,'dln' => 1,'name' => 2,'dob' => 3,'address_street' => 4,'address_city' => 5,'address_state' => 6,'address_zip5' => 7,'address_zip4' => 8,'gender' => 9,'height' => 10,'weight' => 11,'eye_color' => 12,'hair_color' => 13,'license_type' => 14,'title' => 15,'fname' => 16,'mname' => 17,'lname' => 18,'name_suffix' => 19,'cleaning_score' => 20,'prim_range' => 21,'predir' => 22,'prim_name' => 23,'suffix' => 24,'postdir' => 25,'unit_desig' => 26,'sec_range' => 27,'p_city_name' => 28,'v_city_name' => 29,'state' => 30,'zip' => 31,'zip4' => 32,'cart' => 33,'cr_sort_sz' => 34,'lot' => 35,'lot_order' => 36,'dpbc' => 37,'chk_digit' => 38,'rec_type' => 39,'ace_fips_st' => 40,'county' => 41,'geo_lat' => 42,'geo_long' => 43,'msa' => 44,'geo_blk' => 45,'geo_match' => 46,'err_stat' => 47,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_dln(SALT35.StrType s0) := MakeFT_invalid_dln(s0);
EXPORT InValid_dln(SALT35.StrType s) := InValidFT_invalid_dln(s);
EXPORT InValidMessage_dln(UNSIGNED1 wh) := InValidMessageFT_invalid_dln(wh);
 
EXPORT Make_name(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_name(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_dob(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dob(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_address_street(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address_street(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address_street(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_address_city(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address_city(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_address_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_address_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_address_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_address_zip5(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_address_zip5(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_address_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_address_zip4(SALT35.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_address_zip4(SALT35.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_address_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_gender(SALT35.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT35.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_height(SALT35.StrType s0) := MakeFT_invalid_height(s0);
EXPORT InValid_height(SALT35.StrType s) := InValidFT_invalid_height(s);
EXPORT InValidMessage_height(UNSIGNED1 wh) := InValidMessageFT_invalid_height(wh);
 
EXPORT Make_weight(SALT35.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_weight(SALT35.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_weight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
 
EXPORT Make_eye_color(SALT35.StrType s0) := MakeFT_invalid_eye_color(s0);
EXPORT InValid_eye_color(SALT35.StrType s) := InValidFT_invalid_eye_color(s);
EXPORT InValidMessage_eye_color(UNSIGNED1 wh) := InValidMessageFT_invalid_eye_color(wh);
 
EXPORT Make_hair_color(SALT35.StrType s0) := MakeFT_invalid_hair_color(s0);
EXPORT InValid_hair_color(SALT35.StrType s) := InValidFT_invalid_hair_color(s);
EXPORT InValidMessage_hair_color(UNSIGNED1 wh) := InValidMessageFT_invalid_hair_color(wh);
 
EXPORT Make_license_type(SALT35.StrType s0) := MakeFT_invalid_license_type(s0);
EXPORT InValid_license_type(SALT35.StrType s) := InValidFT_invalid_license_type(s);
EXPORT InValidMessage_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_license_type(wh);
 
EXPORT Make_title(SALT35.StrType s0) := s0;
EXPORT InValid_title(SALT35.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT35.StrType s0) := s0;
EXPORT InValid_fname(SALT35.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT35.StrType s0) := s0;
EXPORT InValid_mname(SALT35.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT35.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := InValidFT_invalid_name(s,fname,mname);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaning_score(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_cleaning_score(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_cleaning_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_suffix(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_postdir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_p_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_v_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_v_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
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
  IMPORT SALT35,Scrubs_DL_NE;
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
    BOOLEAN Diff_dln;
    BOOLEAN Diff_name;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_address_street;
    BOOLEAN Diff_address_city;
    BOOLEAN Diff_address_state;
    BOOLEAN Diff_address_zip5;
    BOOLEAN Diff_address_zip4;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_height;
    BOOLEAN Diff_weight;
    BOOLEAN Diff_eye_color;
    BOOLEAN Diff_hair_color;
    BOOLEAN Diff_license_type;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cleaning_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_state;
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
    SELF.Diff_dln := le.dln <> ri.dln;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_address_street := le.address_street <> ri.address_street;
    SELF.Diff_address_city := le.address_city <> ri.address_city;
    SELF.Diff_address_state := le.address_state <> ri.address_state;
    SELF.Diff_address_zip5 := le.address_zip5 <> ri.address_zip5;
    SELF.Diff_address_zip4 := le.address_zip4 <> ri.address_zip4;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_weight := le.weight <> ri.weight;
    SELF.Diff_eye_color := le.eye_color <> ri.eye_color;
    SELF.Diff_hair_color := le.hair_color <> ri.hair_color;
    SELF.Diff_license_type := le.license_type <> ri.license_type;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cleaning_score := le.cleaning_score <> ri.cleaning_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_state := le.state <> ri.state;
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
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dln,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_address_street,1,0)+ IF( SELF.Diff_address_city,1,0)+ IF( SELF.Diff_address_state,1,0)+ IF( SELF.Diff_address_zip5,1,0)+ IF( SELF.Diff_address_zip4,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_weight,1,0)+ IF( SELF.Diff_eye_color,1,0)+ IF( SELF.Diff_hair_color,1,0)+ IF( SELF.Diff_license_type,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cleaning_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_dln := COUNT(GROUP,%Closest%.Diff_dln);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_address_street := COUNT(GROUP,%Closest%.Diff_address_street);
    Count_Diff_address_city := COUNT(GROUP,%Closest%.Diff_address_city);
    Count_Diff_address_state := COUNT(GROUP,%Closest%.Diff_address_state);
    Count_Diff_address_zip5 := COUNT(GROUP,%Closest%.Diff_address_zip5);
    Count_Diff_address_zip4 := COUNT(GROUP,%Closest%.Diff_address_zip4);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_weight := COUNT(GROUP,%Closest%.Diff_weight);
    Count_Diff_eye_color := COUNT(GROUP,%Closest%.Diff_eye_color);
    Count_Diff_hair_color := COUNT(GROUP,%Closest%.Diff_hair_color);
    Count_Diff_license_type := COUNT(GROUP,%Closest%.Diff_license_type);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cleaning_score := COUNT(GROUP,%Closest%.Diff_cleaning_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
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
