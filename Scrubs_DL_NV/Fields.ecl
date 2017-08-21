IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NV; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_wordbag','invalid_6pastdate','invalid_8pastdate','invalid_name','invalid_dln','invalid_perm_cd','invalid_state','invalid_zip5','invalid_clean_name','invalid_direction','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_num_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_wordbag' => 8,'invalid_6pastdate' => 9,'invalid_8pastdate' => 10,'invalid_name' => 11,'invalid_dln' => 12,'invalid_perm_cd' => 13,'invalid_state' => 14,'invalid_zip5' => 15,'invalid_clean_name' => 16,'invalid_direction' => 17,'invalid_zip4' => 18,'invalid_cart' => 19,'invalid_cr_sort_sz' => 20,'invalid_lot' => 21,'invalid_lot_order' => 22,'invalid_dpbc' => 23,'invalid_chk_digit' => 24,'invalid_record_type' => 25,'invalid_ace_fips_st' => 26,'invalid_fipscounty' => 27,'invalid_geo' => 28,'invalid_msa' => 29,'invalid_geo_blk' => 30,'invalid_geo_match' => 31,'invalid_err_stat' => 32,0);
 
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
 
EXPORT MakeFT_invalid_6pastdate(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_6pastdate(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~Scrubs.valid_date.fn_valid_0468pastDate(s)>0,~(LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_6pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.CustomFail('Scrubs.valid_date.fn_valid_0468pastDate'),SALT35.HygieneErrors.NotLength('6'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT35.StrType s,SALT35.StrType fst_name,SALT35.StrType mid_name) := WHICH(~Scrubs_DL_NV.Functions.fn_valid_name(s,fst_name,mid_name)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NV.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dln(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_dln(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_dln(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('10'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_perm_cd(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_perm_cd(SALT35.StrType s) := WHICH(~Scrubs_DL_NV.Functions.fn_perm_cd(s)>0);
EXPORT InValidMessageFT_invalid_perm_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NV.Functions.fn_perm_cd'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(~Scrubs_DL_NV.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NV.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip5(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_clean_name(SALT35.StrType s,SALT35.StrType clean_name_first,SALT35.StrType clean_name_middle) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'))),~Scrubs_DL_NV.Functions.fn_valid_name(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_NV.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ENSW'),SALT35.HygieneErrors.Good);
 
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
EXPORT InValidFT_invalid_record_type(SALT35.StrType s) := WHICH(~Scrubs_DL_NV.Functions.fn_addr_rec_type(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_NV.Functions.fn_addr_rec_type'),SALT35.HygieneErrors.NotLength('0,1,2'),SALT35.HygieneErrors.Good);
 
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
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','lst_name','fst_name','mid_name','dob','dln','perm_cd_1','perm_cd_2','perm_cd_3','perm_cd_4','eff_dt','m_addr','m_city','m_state','m_zip','p_addr','p_city','p_state','p_zip','lf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_m_prim_range','clean_m_predir','clean_m_prim_name','clean_m_addr_suffix','clean_m_postdir','clean_m_unit_desig','clean_m_sec_range','clean_m_p_city_name','clean_m_v_city_name','clean_m_st','clean_m_zip','clean_m_zip4','clean_m_cart','clean_m_cr_sort_sz','clean_m_lot','clean_m_lot_order','clean_m_dpbc','clean_m_chk_digit','clean_m_record_type','clean_m_ace_fips_st','clean_m_fipscounty','clean_m_geo_lat','clean_m_geo_long','clean_m_msa','clean_m_geo_blk','clean_m_geo_match','clean_m_err_stat','clean_p_prim_range','clean_p_predir','clean_p_prim_name','clean_p_addr_suffix','clean_p_postdir','clean_p_unit_desig','clean_p_sec_range','clean_p_p_city_name','clean_p_v_city_name','clean_p_st','clean_p_zip','clean_p_zip4','clean_p_cart','clean_p_cr_sort_sz','clean_p_lot','clean_p_lot_order','clean_p_dpbc','clean_p_chk_digit','clean_p_record_type','clean_p_ace_fips_st','clean_p_fipscounty','clean_p_geo_lat','clean_p_geo_long','clean_p_msa','clean_p_geo_blk','clean_p_geo_match','clean_p_err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'append_process_date' => 0,'dt_first_seen' => 1,'dt_last_seen' => 2,'dt_vendor_first_reported' => 3,'dt_vendor_last_reported' => 4,'lst_name' => 5,'fst_name' => 6,'mid_name' => 7,'dob' => 8,'dln' => 9,'perm_cd_1' => 10,'perm_cd_2' => 11,'perm_cd_3' => 12,'perm_cd_4' => 13,'eff_dt' => 14,'m_addr' => 15,'m_city' => 16,'m_state' => 17,'m_zip' => 18,'p_addr' => 19,'p_city' => 20,'p_state' => 21,'p_zip' => 22,'lf' => 23,'clean_name_prefix' => 24,'clean_name_first' => 25,'clean_name_middle' => 26,'clean_name_last' => 27,'clean_name_suffix' => 28,'clean_name_score' => 29,'clean_m_prim_range' => 30,'clean_m_predir' => 31,'clean_m_prim_name' => 32,'clean_m_addr_suffix' => 33,'clean_m_postdir' => 34,'clean_m_unit_desig' => 35,'clean_m_sec_range' => 36,'clean_m_p_city_name' => 37,'clean_m_v_city_name' => 38,'clean_m_st' => 39,'clean_m_zip' => 40,'clean_m_zip4' => 41,'clean_m_cart' => 42,'clean_m_cr_sort_sz' => 43,'clean_m_lot' => 44,'clean_m_lot_order' => 45,'clean_m_dpbc' => 46,'clean_m_chk_digit' => 47,'clean_m_record_type' => 48,'clean_m_ace_fips_st' => 49,'clean_m_fipscounty' => 50,'clean_m_geo_lat' => 51,'clean_m_geo_long' => 52,'clean_m_msa' => 53,'clean_m_geo_blk' => 54,'clean_m_geo_match' => 55,'clean_m_err_stat' => 56,'clean_p_prim_range' => 57,'clean_p_predir' => 58,'clean_p_prim_name' => 59,'clean_p_addr_suffix' => 60,'clean_p_postdir' => 61,'clean_p_unit_desig' => 62,'clean_p_sec_range' => 63,'clean_p_p_city_name' => 64,'clean_p_v_city_name' => 65,'clean_p_st' => 66,'clean_p_zip' => 67,'clean_p_zip4' => 68,'clean_p_cart' => 69,'clean_p_cr_sort_sz' => 70,'clean_p_lot' => 71,'clean_p_lot_order' => 72,'clean_p_dpbc' => 73,'clean_p_chk_digit' => 74,'clean_p_record_type' => 75,'clean_p_ace_fips_st' => 76,'clean_p_fipscounty' => 77,'clean_p_geo_lat' => 78,'clean_p_geo_long' => 79,'clean_p_msa' => 80,'clean_p_geo_blk' => 81,'clean_p_geo_match' => 82,'clean_p_err_stat' => 83,0);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_append_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_dt_first_seen(SALT35.StrType s0) := MakeFT_invalid_6pastdate(s0);
EXPORT InValid_dt_first_seen(SALT35.StrType s) := InValidFT_invalid_6pastdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_6pastdate(wh);
 
EXPORT Make_dt_last_seen(SALT35.StrType s0) := MakeFT_invalid_6pastdate(s0);
EXPORT InValid_dt_last_seen(SALT35.StrType s) := InValidFT_invalid_6pastdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_6pastdate(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT35.StrType s0) := MakeFT_invalid_6pastdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT35.StrType s) := InValidFT_invalid_6pastdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_6pastdate(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT35.StrType s0) := MakeFT_invalid_6pastdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT35.StrType s) := InValidFT_invalid_6pastdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_6pastdate(wh);
 
EXPORT Make_lst_name(SALT35.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lst_name(SALT35.StrType s,SALT35.StrType fst_name,SALT35.StrType mid_name) := InValidFT_invalid_name(s,fst_name,mid_name);
EXPORT InValidMessage_lst_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_fst_name(SALT35.StrType s0) := s0;
EXPORT InValid_fst_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_fst_name(UNSIGNED1 wh) := '';
 
EXPORT Make_mid_name(SALT35.StrType s0) := s0;
EXPORT InValid_mid_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_mid_name(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dob(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_dln(SALT35.StrType s0) := MakeFT_invalid_dln(s0);
EXPORT InValid_dln(SALT35.StrType s) := InValidFT_invalid_dln(s);
EXPORT InValidMessage_dln(UNSIGNED1 wh) := InValidMessageFT_invalid_dln(wh);
 
EXPORT Make_perm_cd_1(SALT35.StrType s0) := MakeFT_invalid_perm_cd(s0);
EXPORT InValid_perm_cd_1(SALT35.StrType s) := InValidFT_invalid_perm_cd(s);
EXPORT InValidMessage_perm_cd_1(UNSIGNED1 wh) := InValidMessageFT_invalid_perm_cd(wh);
 
EXPORT Make_perm_cd_2(SALT35.StrType s0) := MakeFT_invalid_perm_cd(s0);
EXPORT InValid_perm_cd_2(SALT35.StrType s) := InValidFT_invalid_perm_cd(s);
EXPORT InValidMessage_perm_cd_2(UNSIGNED1 wh) := InValidMessageFT_invalid_perm_cd(wh);
 
EXPORT Make_perm_cd_3(SALT35.StrType s0) := MakeFT_invalid_perm_cd(s0);
EXPORT InValid_perm_cd_3(SALT35.StrType s) := InValidFT_invalid_perm_cd(s);
EXPORT InValidMessage_perm_cd_3(UNSIGNED1 wh) := InValidMessageFT_invalid_perm_cd(wh);
 
EXPORT Make_perm_cd_4(SALT35.StrType s0) := MakeFT_invalid_perm_cd(s0);
EXPORT InValid_perm_cd_4(SALT35.StrType s) := InValidFT_invalid_perm_cd(s);
EXPORT InValidMessage_perm_cd_4(UNSIGNED1 wh) := InValidMessageFT_invalid_perm_cd(wh);
 
EXPORT Make_eff_dt(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_eff_dt(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_eff_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_m_addr(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_m_addr(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_m_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_m_city(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_m_city(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_m_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_m_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_m_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_m_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_m_zip(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_m_zip(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_m_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_p_addr(SALT35.StrType s0) := s0;
EXPORT InValid_p_addr(SALT35.StrType s) := 0;
EXPORT InValidMessage_p_addr(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_p_city(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_p_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_p_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_p_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_p_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_p_zip(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_p_zip(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_p_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_lf(SALT35.StrType s0) := s0;
EXPORT InValid_lf(SALT35.StrType s) := 0;
EXPORT InValidMessage_lf(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_clean_name_score(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_m_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_m_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_m_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_m_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_m_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_clean_m_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_m_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_m_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_m_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_postdir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_m_postdir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_m_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_m_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_clean_m_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_m_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_m_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_m_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_m_p_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_clean_m_p_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_clean_m_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_clean_m_v_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_clean_m_v_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_clean_m_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_clean_m_st(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_clean_m_st(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_clean_m_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_clean_m_zip(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_clean_m_zip(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_clean_m_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_clean_m_zip4(SALT35.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_clean_m_zip4(SALT35.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_clean_m_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_clean_m_cart(SALT35.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_clean_m_cart(SALT35.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_clean_m_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_clean_m_cr_sort_sz(SALT35.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_clean_m_cr_sort_sz(SALT35.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_clean_m_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_clean_m_lot(SALT35.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_clean_m_lot(SALT35.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_clean_m_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_clean_m_lot_order(SALT35.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_clean_m_lot_order(SALT35.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_clean_m_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_clean_m_dpbc(SALT35.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_clean_m_dpbc(SALT35.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_clean_m_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_clean_m_chk_digit(SALT35.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_clean_m_chk_digit(SALT35.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_clean_m_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_clean_m_record_type(SALT35.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_clean_m_record_type(SALT35.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_clean_m_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_clean_m_ace_fips_st(SALT35.StrType s0) := MakeFT_invalid_ace_fips_st(s0);
EXPORT InValid_clean_m_ace_fips_st(SALT35.StrType s) := InValidFT_invalid_ace_fips_st(s);
EXPORT InValidMessage_clean_m_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_fips_st(wh);
 
EXPORT Make_clean_m_fipscounty(SALT35.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_clean_m_fipscounty(SALT35.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_clean_m_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
 
EXPORT Make_clean_m_geo_lat(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_m_geo_lat(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_m_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_m_geo_long(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_m_geo_long(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_m_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_m_msa(SALT35.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_clean_m_msa(SALT35.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_clean_m_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_clean_m_geo_blk(SALT35.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_clean_m_geo_blk(SALT35.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_clean_m_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_clean_m_geo_match(SALT35.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_clean_m_geo_match(SALT35.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_clean_m_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_clean_m_err_stat(SALT35.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_clean_m_err_stat(SALT35.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_clean_m_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_clean_p_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_predir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_p_predir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_p_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_p_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_postdir(SALT35.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_p_postdir(SALT35.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_p_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_p_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_p_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_clean_p_p_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_clean_p_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_clean_p_v_city_name(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_clean_p_v_city_name(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_clean_p_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_clean_p_st(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_clean_p_st(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_clean_p_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_clean_p_zip(SALT35.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_clean_p_zip(SALT35.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_clean_p_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_clean_p_zip4(SALT35.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_clean_p_zip4(SALT35.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_clean_p_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_clean_p_cart(SALT35.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_clean_p_cart(SALT35.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_clean_p_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_clean_p_cr_sort_sz(SALT35.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_clean_p_cr_sort_sz(SALT35.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_clean_p_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_clean_p_lot(SALT35.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_clean_p_lot(SALT35.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_clean_p_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_clean_p_lot_order(SALT35.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_clean_p_lot_order(SALT35.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_clean_p_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_clean_p_dpbc(SALT35.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_clean_p_dpbc(SALT35.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_clean_p_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_clean_p_chk_digit(SALT35.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_clean_p_chk_digit(SALT35.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_clean_p_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_clean_p_record_type(SALT35.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_clean_p_record_type(SALT35.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_clean_p_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_clean_p_ace_fips_st(SALT35.StrType s0) := MakeFT_invalid_ace_fips_st(s0);
EXPORT InValid_clean_p_ace_fips_st(SALT35.StrType s) := InValidFT_invalid_ace_fips_st(s);
EXPORT InValidMessage_clean_p_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_fips_st(wh);
 
EXPORT Make_clean_p_fipscounty(SALT35.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_clean_p_fipscounty(SALT35.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_clean_p_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
 
EXPORT Make_clean_p_geo_lat(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_p_geo_lat(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_p_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_p_geo_long(SALT35.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_clean_p_geo_long(SALT35.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_clean_p_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_clean_p_msa(SALT35.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_clean_p_msa(SALT35.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_clean_p_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_clean_p_geo_blk(SALT35.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_clean_p_geo_blk(SALT35.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_clean_p_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_clean_p_geo_match(SALT35.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_clean_p_geo_match(SALT35.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_clean_p_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_clean_p_err_stat(SALT35.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_clean_p_err_stat(SALT35.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_clean_p_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_NV;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_lst_name;
    BOOLEAN Diff_fst_name;
    BOOLEAN Diff_mid_name;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_dln;
    BOOLEAN Diff_perm_cd_1;
    BOOLEAN Diff_perm_cd_2;
    BOOLEAN Diff_perm_cd_3;
    BOOLEAN Diff_perm_cd_4;
    BOOLEAN Diff_eff_dt;
    BOOLEAN Diff_m_addr;
    BOOLEAN Diff_m_city;
    BOOLEAN Diff_m_state;
    BOOLEAN Diff_m_zip;
    BOOLEAN Diff_p_addr;
    BOOLEAN Diff_p_city;
    BOOLEAN Diff_p_state;
    BOOLEAN Diff_p_zip;
    BOOLEAN Diff_lf;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    BOOLEAN Diff_clean_m_prim_range;
    BOOLEAN Diff_clean_m_predir;
    BOOLEAN Diff_clean_m_prim_name;
    BOOLEAN Diff_clean_m_addr_suffix;
    BOOLEAN Diff_clean_m_postdir;
    BOOLEAN Diff_clean_m_unit_desig;
    BOOLEAN Diff_clean_m_sec_range;
    BOOLEAN Diff_clean_m_p_city_name;
    BOOLEAN Diff_clean_m_v_city_name;
    BOOLEAN Diff_clean_m_st;
    BOOLEAN Diff_clean_m_zip;
    BOOLEAN Diff_clean_m_zip4;
    BOOLEAN Diff_clean_m_cart;
    BOOLEAN Diff_clean_m_cr_sort_sz;
    BOOLEAN Diff_clean_m_lot;
    BOOLEAN Diff_clean_m_lot_order;
    BOOLEAN Diff_clean_m_dpbc;
    BOOLEAN Diff_clean_m_chk_digit;
    BOOLEAN Diff_clean_m_record_type;
    BOOLEAN Diff_clean_m_ace_fips_st;
    BOOLEAN Diff_clean_m_fipscounty;
    BOOLEAN Diff_clean_m_geo_lat;
    BOOLEAN Diff_clean_m_geo_long;
    BOOLEAN Diff_clean_m_msa;
    BOOLEAN Diff_clean_m_geo_blk;
    BOOLEAN Diff_clean_m_geo_match;
    BOOLEAN Diff_clean_m_err_stat;
    BOOLEAN Diff_clean_p_prim_range;
    BOOLEAN Diff_clean_p_predir;
    BOOLEAN Diff_clean_p_prim_name;
    BOOLEAN Diff_clean_p_addr_suffix;
    BOOLEAN Diff_clean_p_postdir;
    BOOLEAN Diff_clean_p_unit_desig;
    BOOLEAN Diff_clean_p_sec_range;
    BOOLEAN Diff_clean_p_p_city_name;
    BOOLEAN Diff_clean_p_v_city_name;
    BOOLEAN Diff_clean_p_st;
    BOOLEAN Diff_clean_p_zip;
    BOOLEAN Diff_clean_p_zip4;
    BOOLEAN Diff_clean_p_cart;
    BOOLEAN Diff_clean_p_cr_sort_sz;
    BOOLEAN Diff_clean_p_lot;
    BOOLEAN Diff_clean_p_lot_order;
    BOOLEAN Diff_clean_p_dpbc;
    BOOLEAN Diff_clean_p_chk_digit;
    BOOLEAN Diff_clean_p_record_type;
    BOOLEAN Diff_clean_p_ace_fips_st;
    BOOLEAN Diff_clean_p_fipscounty;
    BOOLEAN Diff_clean_p_geo_lat;
    BOOLEAN Diff_clean_p_geo_long;
    BOOLEAN Diff_clean_p_msa;
    BOOLEAN Diff_clean_p_geo_blk;
    BOOLEAN Diff_clean_p_geo_match;
    BOOLEAN Diff_clean_p_err_stat;
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_lst_name := le.lst_name <> ri.lst_name;
    SELF.Diff_fst_name := le.fst_name <> ri.fst_name;
    SELF.Diff_mid_name := le.mid_name <> ri.mid_name;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_dln := le.dln <> ri.dln;
    SELF.Diff_perm_cd_1 := le.perm_cd_1 <> ri.perm_cd_1;
    SELF.Diff_perm_cd_2 := le.perm_cd_2 <> ri.perm_cd_2;
    SELF.Diff_perm_cd_3 := le.perm_cd_3 <> ri.perm_cd_3;
    SELF.Diff_perm_cd_4 := le.perm_cd_4 <> ri.perm_cd_4;
    SELF.Diff_eff_dt := le.eff_dt <> ri.eff_dt;
    SELF.Diff_m_addr := le.m_addr <> ri.m_addr;
    SELF.Diff_m_city := le.m_city <> ri.m_city;
    SELF.Diff_m_state := le.m_state <> ri.m_state;
    SELF.Diff_m_zip := le.m_zip <> ri.m_zip;
    SELF.Diff_p_addr := le.p_addr <> ri.p_addr;
    SELF.Diff_p_city := le.p_city <> ri.p_city;
    SELF.Diff_p_state := le.p_state <> ri.p_state;
    SELF.Diff_p_zip := le.p_zip <> ri.p_zip;
    SELF.Diff_lf := le.lf <> ri.lf;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Diff_clean_m_prim_range := le.clean_m_prim_range <> ri.clean_m_prim_range;
    SELF.Diff_clean_m_predir := le.clean_m_predir <> ri.clean_m_predir;
    SELF.Diff_clean_m_prim_name := le.clean_m_prim_name <> ri.clean_m_prim_name;
    SELF.Diff_clean_m_addr_suffix := le.clean_m_addr_suffix <> ri.clean_m_addr_suffix;
    SELF.Diff_clean_m_postdir := le.clean_m_postdir <> ri.clean_m_postdir;
    SELF.Diff_clean_m_unit_desig := le.clean_m_unit_desig <> ri.clean_m_unit_desig;
    SELF.Diff_clean_m_sec_range := le.clean_m_sec_range <> ri.clean_m_sec_range;
    SELF.Diff_clean_m_p_city_name := le.clean_m_p_city_name <> ri.clean_m_p_city_name;
    SELF.Diff_clean_m_v_city_name := le.clean_m_v_city_name <> ri.clean_m_v_city_name;
    SELF.Diff_clean_m_st := le.clean_m_st <> ri.clean_m_st;
    SELF.Diff_clean_m_zip := le.clean_m_zip <> ri.clean_m_zip;
    SELF.Diff_clean_m_zip4 := le.clean_m_zip4 <> ri.clean_m_zip4;
    SELF.Diff_clean_m_cart := le.clean_m_cart <> ri.clean_m_cart;
    SELF.Diff_clean_m_cr_sort_sz := le.clean_m_cr_sort_sz <> ri.clean_m_cr_sort_sz;
    SELF.Diff_clean_m_lot := le.clean_m_lot <> ri.clean_m_lot;
    SELF.Diff_clean_m_lot_order := le.clean_m_lot_order <> ri.clean_m_lot_order;
    SELF.Diff_clean_m_dpbc := le.clean_m_dpbc <> ri.clean_m_dpbc;
    SELF.Diff_clean_m_chk_digit := le.clean_m_chk_digit <> ri.clean_m_chk_digit;
    SELF.Diff_clean_m_record_type := le.clean_m_record_type <> ri.clean_m_record_type;
    SELF.Diff_clean_m_ace_fips_st := le.clean_m_ace_fips_st <> ri.clean_m_ace_fips_st;
    SELF.Diff_clean_m_fipscounty := le.clean_m_fipscounty <> ri.clean_m_fipscounty;
    SELF.Diff_clean_m_geo_lat := le.clean_m_geo_lat <> ri.clean_m_geo_lat;
    SELF.Diff_clean_m_geo_long := le.clean_m_geo_long <> ri.clean_m_geo_long;
    SELF.Diff_clean_m_msa := le.clean_m_msa <> ri.clean_m_msa;
    SELF.Diff_clean_m_geo_blk := le.clean_m_geo_blk <> ri.clean_m_geo_blk;
    SELF.Diff_clean_m_geo_match := le.clean_m_geo_match <> ri.clean_m_geo_match;
    SELF.Diff_clean_m_err_stat := le.clean_m_err_stat <> ri.clean_m_err_stat;
    SELF.Diff_clean_p_prim_range := le.clean_p_prim_range <> ri.clean_p_prim_range;
    SELF.Diff_clean_p_predir := le.clean_p_predir <> ri.clean_p_predir;
    SELF.Diff_clean_p_prim_name := le.clean_p_prim_name <> ri.clean_p_prim_name;
    SELF.Diff_clean_p_addr_suffix := le.clean_p_addr_suffix <> ri.clean_p_addr_suffix;
    SELF.Diff_clean_p_postdir := le.clean_p_postdir <> ri.clean_p_postdir;
    SELF.Diff_clean_p_unit_desig := le.clean_p_unit_desig <> ri.clean_p_unit_desig;
    SELF.Diff_clean_p_sec_range := le.clean_p_sec_range <> ri.clean_p_sec_range;
    SELF.Diff_clean_p_p_city_name := le.clean_p_p_city_name <> ri.clean_p_p_city_name;
    SELF.Diff_clean_p_v_city_name := le.clean_p_v_city_name <> ri.clean_p_v_city_name;
    SELF.Diff_clean_p_st := le.clean_p_st <> ri.clean_p_st;
    SELF.Diff_clean_p_zip := le.clean_p_zip <> ri.clean_p_zip;
    SELF.Diff_clean_p_zip4 := le.clean_p_zip4 <> ri.clean_p_zip4;
    SELF.Diff_clean_p_cart := le.clean_p_cart <> ri.clean_p_cart;
    SELF.Diff_clean_p_cr_sort_sz := le.clean_p_cr_sort_sz <> ri.clean_p_cr_sort_sz;
    SELF.Diff_clean_p_lot := le.clean_p_lot <> ri.clean_p_lot;
    SELF.Diff_clean_p_lot_order := le.clean_p_lot_order <> ri.clean_p_lot_order;
    SELF.Diff_clean_p_dpbc := le.clean_p_dpbc <> ri.clean_p_dpbc;
    SELF.Diff_clean_p_chk_digit := le.clean_p_chk_digit <> ri.clean_p_chk_digit;
    SELF.Diff_clean_p_record_type := le.clean_p_record_type <> ri.clean_p_record_type;
    SELF.Diff_clean_p_ace_fips_st := le.clean_p_ace_fips_st <> ri.clean_p_ace_fips_st;
    SELF.Diff_clean_p_fipscounty := le.clean_p_fipscounty <> ri.clean_p_fipscounty;
    SELF.Diff_clean_p_geo_lat := le.clean_p_geo_lat <> ri.clean_p_geo_lat;
    SELF.Diff_clean_p_geo_long := le.clean_p_geo_long <> ri.clean_p_geo_long;
    SELF.Diff_clean_p_msa := le.clean_p_msa <> ri.clean_p_msa;
    SELF.Diff_clean_p_geo_blk := le.clean_p_geo_blk <> ri.clean_p_geo_blk;
    SELF.Diff_clean_p_geo_match := le.clean_p_geo_match <> ri.clean_p_geo_match;
    SELF.Diff_clean_p_err_stat := le.clean_p_err_stat <> ri.clean_p_err_stat;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_lst_name,1,0)+ IF( SELF.Diff_fst_name,1,0)+ IF( SELF.Diff_mid_name,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_dln,1,0)+ IF( SELF.Diff_perm_cd_1,1,0)+ IF( SELF.Diff_perm_cd_2,1,0)+ IF( SELF.Diff_perm_cd_3,1,0)+ IF( SELF.Diff_perm_cd_4,1,0)+ IF( SELF.Diff_eff_dt,1,0)+ IF( SELF.Diff_m_addr,1,0)+ IF( SELF.Diff_m_city,1,0)+ IF( SELF.Diff_m_state,1,0)+ IF( SELF.Diff_m_zip,1,0)+ IF( SELF.Diff_p_addr,1,0)+ IF( SELF.Diff_p_city,1,0)+ IF( SELF.Diff_p_state,1,0)+ IF( SELF.Diff_p_zip,1,0)+ IF( SELF.Diff_lf,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_clean_m_prim_range,1,0)+ IF( SELF.Diff_clean_m_predir,1,0)+ IF( SELF.Diff_clean_m_prim_name,1,0)+ IF( SELF.Diff_clean_m_addr_suffix,1,0)+ IF( SELF.Diff_clean_m_postdir,1,0)+ IF( SELF.Diff_clean_m_unit_desig,1,0)+ IF( SELF.Diff_clean_m_sec_range,1,0)+ IF( SELF.Diff_clean_m_p_city_name,1,0)+ IF( SELF.Diff_clean_m_v_city_name,1,0)+ IF( SELF.Diff_clean_m_st,1,0)+ IF( SELF.Diff_clean_m_zip,1,0)+ IF( SELF.Diff_clean_m_zip4,1,0)+ IF( SELF.Diff_clean_m_cart,1,0)+ IF( SELF.Diff_clean_m_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_m_lot,1,0)+ IF( SELF.Diff_clean_m_lot_order,1,0)+ IF( SELF.Diff_clean_m_dpbc,1,0)+ IF( SELF.Diff_clean_m_chk_digit,1,0)+ IF( SELF.Diff_clean_m_record_type,1,0)+ IF( SELF.Diff_clean_m_ace_fips_st,1,0)+ IF( SELF.Diff_clean_m_fipscounty,1,0)+ IF( SELF.Diff_clean_m_geo_lat,1,0)+ IF( SELF.Diff_clean_m_geo_long,1,0)+ IF( SELF.Diff_clean_m_msa,1,0)+ IF( SELF.Diff_clean_m_geo_blk,1,0)+ IF( SELF.Diff_clean_m_geo_match,1,0)+ IF( SELF.Diff_clean_m_err_stat,1,0)+ IF( SELF.Diff_clean_p_prim_range,1,0)+ IF( SELF.Diff_clean_p_predir,1,0)+ IF( SELF.Diff_clean_p_prim_name,1,0)+ IF( SELF.Diff_clean_p_addr_suffix,1,0)+ IF( SELF.Diff_clean_p_postdir,1,0)+ IF( SELF.Diff_clean_p_unit_desig,1,0)+ IF( SELF.Diff_clean_p_sec_range,1,0)+ IF( SELF.Diff_clean_p_p_city_name,1,0)+ IF( SELF.Diff_clean_p_v_city_name,1,0)+ IF( SELF.Diff_clean_p_st,1,0)+ IF( SELF.Diff_clean_p_zip,1,0)+ IF( SELF.Diff_clean_p_zip4,1,0)+ IF( SELF.Diff_clean_p_cart,1,0)+ IF( SELF.Diff_clean_p_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_p_lot,1,0)+ IF( SELF.Diff_clean_p_lot_order,1,0)+ IF( SELF.Diff_clean_p_dpbc,1,0)+ IF( SELF.Diff_clean_p_chk_digit,1,0)+ IF( SELF.Diff_clean_p_record_type,1,0)+ IF( SELF.Diff_clean_p_ace_fips_st,1,0)+ IF( SELF.Diff_clean_p_fipscounty,1,0)+ IF( SELF.Diff_clean_p_geo_lat,1,0)+ IF( SELF.Diff_clean_p_geo_long,1,0)+ IF( SELF.Diff_clean_p_msa,1,0)+ IF( SELF.Diff_clean_p_geo_blk,1,0)+ IF( SELF.Diff_clean_p_geo_match,1,0)+ IF( SELF.Diff_clean_p_err_stat,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_lst_name := COUNT(GROUP,%Closest%.Diff_lst_name);
    Count_Diff_fst_name := COUNT(GROUP,%Closest%.Diff_fst_name);
    Count_Diff_mid_name := COUNT(GROUP,%Closest%.Diff_mid_name);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_dln := COUNT(GROUP,%Closest%.Diff_dln);
    Count_Diff_perm_cd_1 := COUNT(GROUP,%Closest%.Diff_perm_cd_1);
    Count_Diff_perm_cd_2 := COUNT(GROUP,%Closest%.Diff_perm_cd_2);
    Count_Diff_perm_cd_3 := COUNT(GROUP,%Closest%.Diff_perm_cd_3);
    Count_Diff_perm_cd_4 := COUNT(GROUP,%Closest%.Diff_perm_cd_4);
    Count_Diff_eff_dt := COUNT(GROUP,%Closest%.Diff_eff_dt);
    Count_Diff_m_addr := COUNT(GROUP,%Closest%.Diff_m_addr);
    Count_Diff_m_city := COUNT(GROUP,%Closest%.Diff_m_city);
    Count_Diff_m_state := COUNT(GROUP,%Closest%.Diff_m_state);
    Count_Diff_m_zip := COUNT(GROUP,%Closest%.Diff_m_zip);
    Count_Diff_p_addr := COUNT(GROUP,%Closest%.Diff_p_addr);
    Count_Diff_p_city := COUNT(GROUP,%Closest%.Diff_p_city);
    Count_Diff_p_state := COUNT(GROUP,%Closest%.Diff_p_state);
    Count_Diff_p_zip := COUNT(GROUP,%Closest%.Diff_p_zip);
    Count_Diff_lf := COUNT(GROUP,%Closest%.Diff_lf);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
    Count_Diff_clean_m_prim_range := COUNT(GROUP,%Closest%.Diff_clean_m_prim_range);
    Count_Diff_clean_m_predir := COUNT(GROUP,%Closest%.Diff_clean_m_predir);
    Count_Diff_clean_m_prim_name := COUNT(GROUP,%Closest%.Diff_clean_m_prim_name);
    Count_Diff_clean_m_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_m_addr_suffix);
    Count_Diff_clean_m_postdir := COUNT(GROUP,%Closest%.Diff_clean_m_postdir);
    Count_Diff_clean_m_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_m_unit_desig);
    Count_Diff_clean_m_sec_range := COUNT(GROUP,%Closest%.Diff_clean_m_sec_range);
    Count_Diff_clean_m_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_m_p_city_name);
    Count_Diff_clean_m_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_m_v_city_name);
    Count_Diff_clean_m_st := COUNT(GROUP,%Closest%.Diff_clean_m_st);
    Count_Diff_clean_m_zip := COUNT(GROUP,%Closest%.Diff_clean_m_zip);
    Count_Diff_clean_m_zip4 := COUNT(GROUP,%Closest%.Diff_clean_m_zip4);
    Count_Diff_clean_m_cart := COUNT(GROUP,%Closest%.Diff_clean_m_cart);
    Count_Diff_clean_m_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_m_cr_sort_sz);
    Count_Diff_clean_m_lot := COUNT(GROUP,%Closest%.Diff_clean_m_lot);
    Count_Diff_clean_m_lot_order := COUNT(GROUP,%Closest%.Diff_clean_m_lot_order);
    Count_Diff_clean_m_dpbc := COUNT(GROUP,%Closest%.Diff_clean_m_dpbc);
    Count_Diff_clean_m_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_m_chk_digit);
    Count_Diff_clean_m_record_type := COUNT(GROUP,%Closest%.Diff_clean_m_record_type);
    Count_Diff_clean_m_ace_fips_st := COUNT(GROUP,%Closest%.Diff_clean_m_ace_fips_st);
    Count_Diff_clean_m_fipscounty := COUNT(GROUP,%Closest%.Diff_clean_m_fipscounty);
    Count_Diff_clean_m_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_m_geo_lat);
    Count_Diff_clean_m_geo_long := COUNT(GROUP,%Closest%.Diff_clean_m_geo_long);
    Count_Diff_clean_m_msa := COUNT(GROUP,%Closest%.Diff_clean_m_msa);
    Count_Diff_clean_m_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_m_geo_blk);
    Count_Diff_clean_m_geo_match := COUNT(GROUP,%Closest%.Diff_clean_m_geo_match);
    Count_Diff_clean_m_err_stat := COUNT(GROUP,%Closest%.Diff_clean_m_err_stat);
    Count_Diff_clean_p_prim_range := COUNT(GROUP,%Closest%.Diff_clean_p_prim_range);
    Count_Diff_clean_p_predir := COUNT(GROUP,%Closest%.Diff_clean_p_predir);
    Count_Diff_clean_p_prim_name := COUNT(GROUP,%Closest%.Diff_clean_p_prim_name);
    Count_Diff_clean_p_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_p_addr_suffix);
    Count_Diff_clean_p_postdir := COUNT(GROUP,%Closest%.Diff_clean_p_postdir);
    Count_Diff_clean_p_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_p_unit_desig);
    Count_Diff_clean_p_sec_range := COUNT(GROUP,%Closest%.Diff_clean_p_sec_range);
    Count_Diff_clean_p_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_p_p_city_name);
    Count_Diff_clean_p_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_p_v_city_name);
    Count_Diff_clean_p_st := COUNT(GROUP,%Closest%.Diff_clean_p_st);
    Count_Diff_clean_p_zip := COUNT(GROUP,%Closest%.Diff_clean_p_zip);
    Count_Diff_clean_p_zip4 := COUNT(GROUP,%Closest%.Diff_clean_p_zip4);
    Count_Diff_clean_p_cart := COUNT(GROUP,%Closest%.Diff_clean_p_cart);
    Count_Diff_clean_p_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_p_cr_sort_sz);
    Count_Diff_clean_p_lot := COUNT(GROUP,%Closest%.Diff_clean_p_lot);
    Count_Diff_clean_p_lot_order := COUNT(GROUP,%Closest%.Diff_clean_p_lot_order);
    Count_Diff_clean_p_dpbc := COUNT(GROUP,%Closest%.Diff_clean_p_dpbc);
    Count_Diff_clean_p_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_p_chk_digit);
    Count_Diff_clean_p_record_type := COUNT(GROUP,%Closest%.Diff_clean_p_record_type);
    Count_Diff_clean_p_ace_fips_st := COUNT(GROUP,%Closest%.Diff_clean_p_ace_fips_st);
    Count_Diff_clean_p_fipscounty := COUNT(GROUP,%Closest%.Diff_clean_p_fipscounty);
    Count_Diff_clean_p_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_p_geo_lat);
    Count_Diff_clean_p_geo_long := COUNT(GROUP,%Closest%.Diff_clean_p_geo_long);
    Count_Diff_clean_p_msa := COUNT(GROUP,%Closest%.Diff_clean_p_msa);
    Count_Diff_clean_p_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_p_geo_blk);
    Count_Diff_clean_p_geo_match := COUNT(GROUP,%Closest%.Diff_clean_p_geo_match);
    Count_Diff_clean_p_err_stat := COUNT(GROUP,%Closest%.Diff_clean_p_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
