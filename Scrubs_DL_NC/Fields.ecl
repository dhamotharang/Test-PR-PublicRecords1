IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NC; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_wordbag','invalid_8pastdate','invalid_8generaldate','invalid_license_number','invalid_name','invalid_state','invalid_zip','invalid_licensetype','invalid_status','invalid_clean_name','invalid_direction','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_num_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_wordbag' => 8,'invalid_8pastdate' => 9,'invalid_8generaldate' => 10,'invalid_license_number' => 11,'invalid_name' => 12,'invalid_state' => 13,'invalid_zip' => 14,'invalid_licensetype' => 15,'invalid_status' => 16,'invalid_clean_name' => 17,'invalid_direction' => 18,'invalid_zip5' => 19,'invalid_zip4' => 20,'invalid_cart' => 21,'invalid_cr_sort_sz' => 22,'invalid_lot' => 23,'invalid_lot_order' => 24,'invalid_dpbc' => 25,'invalid_chk_digit' => 26,'invalid_record_type' => 27,'invalid_ace_fips_st' => 28,'invalid_fipscounty' => 29,'invalid_geo' => 30,'invalid_msa' => 31,'invalid_geo_blk' => 32,'invalid_geo_match' => 33,'invalid_err_stat' => 34,0);
 
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
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ /\'@-.,#'),SALT35.HygieneErrors.Good);
 
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
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'),SALT35.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_license_number(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_license_number(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 12));
EXPORT InValidMessageFT_invalid_license_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('12'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_name(SALT35.StrType s,SALT35.StrType firstname,SALT35.StrType middlename) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'))),~Scrubs_DL_NC.Functions.fn_valid_name(s,firstname,middlename)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_NC.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha(s1);
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.NotLength('0,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,5,9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_licensetype(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_licensetype(SALT35.StrType s) := WHICH(~Scrubs_DL_NC.Functions.fn_check_license_type(s)>0);
EXPORT InValidMessageFT_invalid_licensetype(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NC.Functions.fn_check_license_type'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status(SALT35.StrType s) := WHICH(~Scrubs_DL_NC.Functions.fn_check_status(s)>0);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NC.Functions.fn_check_status'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_clean_name(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'))),~Scrubs_DL_NC.Functions.fn_valid_name(s,fname,mname)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_NC.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ENSW'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip5(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_record_type(SALT35.StrType s) := WHICH(~Scrubs_DL_NC.Functions.fn_addr_rec_type(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NC.Functions.fn_addr_rec_type'),SALT35.HygieneErrors.NotLength('0,1,2'),SALT35.HygieneErrors.Good);
 
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
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','customer_id','license_number','firstname','middlename','lastname','suffix','address1','address2','city','state','zip','dob','licensetype','issuedate','expiration','restriction1','restriction2','restriction3','restriction4','restriction5','status','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'process_date' => 0,'customer_id' => 1,'license_number' => 2,'firstname' => 3,'middlename' => 4,'lastname' => 5,'suffix' => 6,'address1' => 7,'address2' => 8,'city' => 9,'state' => 10,'zip' => 11,'dob' => 12,'licensetype' => 13,'issuedate' => 14,'expiration' => 15,'restriction1' => 16,'restriction2' => 17,'restriction3' => 18,'restriction4' => 19,'restriction5' => 20,'status' => 21,'title' => 22,'fname' => 23,'mname' => 24,'lname' => 25,'name_suffix' => 26,'cleaning_score' => 27,'prim_range' => 28,'predir' => 29,'prim_name' => 30,'addr_suffix' => 31,'postdir' => 32,'unit_desig' => 33,'sec_range' => 34,'p_city_name' => 35,'v_city_name' => 36,'st' => 37,'zip5' => 38,'zip4' => 39,'cart' => 40,'cr_sort_sz' => 41,'lot' => 42,'lot_order' => 43,'dpbc' => 44,'chk_digit' => 45,'rec_type' => 46,'ace_fips_st' => 47,'county' => 48,'geo_lat' => 49,'geo_long' => 50,'msa' => 51,'geo_blk' => 52,'geo_match' => 53,'err_stat' => 54,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_customer_id(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_customer_id(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_customer_id(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_license_number(SALT35.StrType s0) := MakeFT_invalid_license_number(s0);
EXPORT InValid_license_number(SALT35.StrType s) := InValidFT_invalid_license_number(s);
EXPORT InValidMessage_license_number(UNSIGNED1 wh) := InValidMessageFT_invalid_license_number(wh);
 
EXPORT Make_firstname(SALT35.StrType s0) := s0;
EXPORT InValid_firstname(SALT35.StrType s) := 0;
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := '';
 
EXPORT Make_middlename(SALT35.StrType s0) := s0;
EXPORT InValid_middlename(SALT35.StrType s) := 0;
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := '';
 
EXPORT Make_lastname(SALT35.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lastname(SALT35.StrType s,SALT35.StrType firstname,SALT35.StrType middlename) := InValidFT_invalid_name(s,firstname,middlename);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT35.StrType s0) := s0;
EXPORT InValid_address1(SALT35.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT35.StrType s0) := s0;
EXPORT InValid_address2(SALT35.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_city(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT35.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT35.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_dob(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dob(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_licensetype(SALT35.StrType s0) := MakeFT_invalid_licensetype(s0);
EXPORT InValid_licensetype(SALT35.StrType s) := InValidFT_invalid_licensetype(s);
EXPORT InValidMessage_licensetype(UNSIGNED1 wh) := InValidMessageFT_invalid_licensetype(wh);
 
EXPORT Make_issuedate(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_issuedate(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_issuedate(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_expiration(SALT35.StrType s0) := MakeFT_invalid_8generaldate(s0);
EXPORT InValid_expiration(SALT35.StrType s) := InValidFT_invalid_8generaldate(s);
EXPORT InValidMessage_expiration(UNSIGNED1 wh) := InValidMessageFT_invalid_8generaldate(wh);
 
EXPORT Make_restriction1(SALT35.StrType s0) := s0;
EXPORT InValid_restriction1(SALT35.StrType s) := 0;
EXPORT InValidMessage_restriction1(UNSIGNED1 wh) := '';
 
EXPORT Make_restriction2(SALT35.StrType s0) := s0;
EXPORT InValid_restriction2(SALT35.StrType s) := 0;
EXPORT InValidMessage_restriction2(UNSIGNED1 wh) := '';
 
EXPORT Make_restriction3(SALT35.StrType s0) := s0;
EXPORT InValid_restriction3(SALT35.StrType s) := 0;
EXPORT InValidMessage_restriction3(UNSIGNED1 wh) := '';
 
EXPORT Make_restriction4(SALT35.StrType s0) := s0;
EXPORT InValid_restriction4(SALT35.StrType s) := 0;
EXPORT InValidMessage_restriction4(UNSIGNED1 wh) := '';
 
EXPORT Make_restriction5(SALT35.StrType s0) := s0;
EXPORT InValid_restriction5(SALT35.StrType s) := 0;
EXPORT InValidMessage_restriction5(UNSIGNED1 wh) := '';
 
EXPORT Make_status(SALT35.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_status(SALT35.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_title(SALT35.StrType s0) := s0;
EXPORT InValid_title(SALT35.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT35.StrType s0) := s0;
EXPORT InValid_fname(SALT35.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT35.StrType s0) := s0;
EXPORT InValid_mname(SALT35.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT35.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_lname(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := InValidFT_invalid_clean_name(s,fname,mname);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaning_score(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_cleaning_score(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_cleaning_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prim_range(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_prim_range(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_st(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip5(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip5(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
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
  IMPORT SALT35,Scrubs_DL_NC;
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
    BOOLEAN Diff_customer_id;
    BOOLEAN Diff_license_number;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_licensetype;
    BOOLEAN Diff_issuedate;
    BOOLEAN Diff_expiration;
    BOOLEAN Diff_restriction1;
    BOOLEAN Diff_restriction2;
    BOOLEAN Diff_restriction3;
    BOOLEAN Diff_restriction4;
    BOOLEAN Diff_restriction5;
    BOOLEAN Diff_status;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cleaning_score;
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
    SELF.Diff_customer_id := le.customer_id <> ri.customer_id;
    SELF.Diff_license_number := le.license_number <> ri.license_number;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_licensetype := le.licensetype <> ri.licensetype;
    SELF.Diff_issuedate := le.issuedate <> ri.issuedate;
    SELF.Diff_expiration := le.expiration <> ri.expiration;
    SELF.Diff_restriction1 := le.restriction1 <> ri.restriction1;
    SELF.Diff_restriction2 := le.restriction2 <> ri.restriction2;
    SELF.Diff_restriction3 := le.restriction3 <> ri.restriction3;
    SELF.Diff_restriction4 := le.restriction4 <> ri.restriction4;
    SELF.Diff_restriction5 := le.restriction5 <> ri.restriction5;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cleaning_score := le.cleaning_score <> ri.cleaning_score;
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
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_customer_id,1,0)+ IF( SELF.Diff_license_number,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_licensetype,1,0)+ IF( SELF.Diff_issuedate,1,0)+ IF( SELF.Diff_expiration,1,0)+ IF( SELF.Diff_restriction1,1,0)+ IF( SELF.Diff_restriction2,1,0)+ IF( SELF.Diff_restriction3,1,0)+ IF( SELF.Diff_restriction4,1,0)+ IF( SELF.Diff_restriction5,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cleaning_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_customer_id := COUNT(GROUP,%Closest%.Diff_customer_id);
    Count_Diff_license_number := COUNT(GROUP,%Closest%.Diff_license_number);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_licensetype := COUNT(GROUP,%Closest%.Diff_licensetype);
    Count_Diff_issuedate := COUNT(GROUP,%Closest%.Diff_issuedate);
    Count_Diff_expiration := COUNT(GROUP,%Closest%.Diff_expiration);
    Count_Diff_restriction1 := COUNT(GROUP,%Closest%.Diff_restriction1);
    Count_Diff_restriction2 := COUNT(GROUP,%Closest%.Diff_restriction2);
    Count_Diff_restriction3 := COUNT(GROUP,%Closest%.Diff_restriction3);
    Count_Diff_restriction4 := COUNT(GROUP,%Closest%.Diff_restriction4);
    Count_Diff_restriction5 := COUNT(GROUP,%Closest%.Diff_restriction5);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cleaning_score := COUNT(GROUP,%Closest%.Diff_cleaning_score);
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
