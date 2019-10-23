IMPORT SALT311;
EXPORT Experian_Fields := MODULE

EXPORT NumFields := 110;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_year','invalid_alpha','invalid_only_alpha','invalid_number','invalid_weight','invalid_alphanumeric','invalid_date','invalid_date1','invalid_state','invalid_file_typ','invalid_vin','invalid_vehicle_typ','invalid_model_yr_ind','invalid_name_typ_cd','invalid_owner_typ_cd','invalid_ssn','invalid_zip5','invalid_zip4','invalid_cc','invalid_opt_out_cd','invalid_yes_no','invalid_min_door_count');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_year' => 1,'invalid_alpha' => 2,'invalid_only_alpha' => 3,'invalid_number' => 4,'invalid_weight' => 5,'invalid_alphanumeric' => 6,'invalid_date' => 7,'invalid_date1' => 8,'invalid_state' => 9,'invalid_file_typ' => 10,'invalid_vin' => 11,'invalid_vehicle_typ' => 12,'invalid_model_yr_ind' => 13,'invalid_name_typ_cd' => 14,'invalid_owner_typ_cd' => 15,'invalid_ssn' => 16,'invalid_zip5' => 17,'invalid_zip4' => 18,'invalid_cc' => 19,'invalid_opt_out_cd' => 20,'invalid_yes_no' => 21,'invalid_min_door_count' => 22,0);

EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~@&\'"`$*-_?% <>{}[]^=!+,.;:/#()\\|'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]^=!+,.;:/#()\\|',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~@&\'"`$*-_?% <>{}[]^=!+,.;:/#()\\|'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~@&\'"`$*-_?% <>{}[]^=!+,.;:/#()\\|'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_only_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_only_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'))));
EXPORT InValidMessageFT_invalid_only_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_weight(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 N/A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_weight(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 N/A'))));
EXPORT InValidMessageFT_invalid_weight(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 N/A'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,.'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,.'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,.'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('8,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_date1(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date1(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789/'))),~(LENGTH(TRIM(s)) >= 6 AND LENGTH(TRIM(s)) <= 10 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date1(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789/'),SALT311.HygieneErrors.NotLength('6..10,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_file_typ(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_file_typ(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['R','T','C','S','I','L','B','U'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_file_typ(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('R|T|C|S|I|L|B|U'),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_vin(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -:;'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -:;',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_vin(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -:;'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_vin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -:;'),SALT311.HygieneErrors.NotLength('0..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_vehicle_typ(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vehicle_typ(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','M','U','X','T',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_vehicle_typ(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|M|U|X|T|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_model_yr_ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_model_yr_ind(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['V','R'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_model_yr_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('V|R'),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_name_typ_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_typ_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','4','5','7',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_name_typ_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|4|5|7|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_owner_typ_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner_typ_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_owner_typ_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_ssn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('9,4,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('5,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('4,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_cc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','  0','  1',''],~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 3));
EXPORT InValidMessageFT_invalid_cc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|  0|  1|'),SALT311.HygieneErrors.NotLength('0..3'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_opt_out_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_opt_out_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','I','M','N','U','X','Y',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_opt_out_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|I|M|N|U|X|Y|'),SALT311.HygieneErrors.NotLength('1,0'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_yes_no(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_yes_no(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N',''],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_yes_no(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N|'),SALT311.HygieneErrors.NotLength('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_min_door_count(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'2345D'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_min_door_count(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'2345D'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_min_door_count(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('2345D'),SALT311.HygieneErrors.NotLength('2,0'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','append_state_origin','file_typ','vin','vehicle_typ','model_yr','model_yr_ind','make','make_ind','series','series_ind','prime_color','second_color','body_style','body_style_ind','model','model_ind','weight','lengt','axle_cnt','plate_nbr','plate_state','prev_plate_nbr','prev_plate_state','plate_typ_cd','mstr_src_state','reg_decal_nbr','org_reg_dt','reg_renew_dt','reg_exp_dt','title_nbr','org_title_dt','title_trans_dt','name_typ_cd','owner_typ_cd','first_nm','middle_nm','last_nm','name_suffix','prof_suffix','ind_ssn','ind_dob','mail_range','m_pre_dir','m_street','m_suffix','m_post_dir','m_pob','m_rr_nbr','m_rr_box','m_scndry_rng','m_scndry_des','m_city','m_state','m_zip5','m_zip4','m_cntry_cd','m_cc_filler','m_cc','m_county','phys_range','p_pre_dir','p_street','p_suffix','p_post_dir','p_pob','p_rr_nbr','p_rr_box','p_scndry_rng','p_scndry_des','p_city','p_state','p_zip5','p_zip4','p_cntry_cd','p_cc_filler','p_cc','p_county','opt_out_cd','asg_wgt','asg_wgt_uom','source_ctl_id','raw_name','branded_title_flag','brand_code_1','brand_date_1','brand_state_1','brand_code_2','brand_date_2','brand_state_2','brand_code_3','brand_date_3','brand_state_3','brand_code_4','brand_date_4','brand_state_4','brand_code_5','brand_date_5','brand_state_5','tod_flag','model_class_code','model_class','min_door_count','safety_type','airbag_driver','airbag_front_driver_side','airbag_front_head_curtain','airbag_front_pass','airbag_front_pass_side','airbags');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','append_state_origin','file_typ','vin','vehicle_typ','model_yr','model_yr_ind','make','make_ind','series','series_ind','prime_color','second_color','body_style','body_style_ind','model','model_ind','weight','lengt','axle_cnt','plate_nbr','plate_state','prev_plate_nbr','prev_plate_state','plate_typ_cd','mstr_src_state','reg_decal_nbr','org_reg_dt','reg_renew_dt','reg_exp_dt','title_nbr','org_title_dt','title_trans_dt','name_typ_cd','owner_typ_cd','first_nm','middle_nm','last_nm','name_suffix','prof_suffix','ind_ssn','ind_dob','mail_range','m_pre_dir','m_street','m_suffix','m_post_dir','m_pob','m_rr_nbr','m_rr_box','m_scndry_rng','m_scndry_des','m_city','m_state','m_zip5','m_zip4','m_cntry_cd','m_cc_filler','m_cc','m_county','phys_range','p_pre_dir','p_street','p_suffix','p_post_dir','p_pob','p_rr_nbr','p_rr_box','p_scndry_rng','p_scndry_des','p_city','p_state','p_zip5','p_zip4','p_cntry_cd','p_cc_filler','p_cc','p_county','opt_out_cd','asg_wgt','asg_wgt_uom','source_ctl_id','raw_name','branded_title_flag','brand_code_1','brand_date_1','brand_state_1','brand_code_2','brand_date_2','brand_state_2','brand_code_3','brand_date_3','brand_state_3','brand_code_4','brand_date_4','brand_state_4','brand_code_5','brand_date_5','brand_state_5','tod_flag','model_class_code','model_class','min_door_count','safety_type','airbag_driver','airbag_front_driver_side','airbag_front_head_curtain','airbag_front_pass','airbag_front_pass_side','airbags');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'append_process_date' => 0,'append_state_origin' => 1,'file_typ' => 2,'vin' => 3,'vehicle_typ' => 4,'model_yr' => 5,'model_yr_ind' => 6,'make' => 7,'make_ind' => 8,'series' => 9,'series_ind' => 10,'prime_color' => 11,'second_color' => 12,'body_style' => 13,'body_style_ind' => 14,'model' => 15,'model_ind' => 16,'weight' => 17,'lengt' => 18,'axle_cnt' => 19,'plate_nbr' => 20,'plate_state' => 21,'prev_plate_nbr' => 22,'prev_plate_state' => 23,'plate_typ_cd' => 24,'mstr_src_state' => 25,'reg_decal_nbr' => 26,'org_reg_dt' => 27,'reg_renew_dt' => 28,'reg_exp_dt' => 29,'title_nbr' => 30,'org_title_dt' => 31,'title_trans_dt' => 32,'name_typ_cd' => 33,'owner_typ_cd' => 34,'first_nm' => 35,'middle_nm' => 36,'last_nm' => 37,'name_suffix' => 38,'prof_suffix' => 39,'ind_ssn' => 40,'ind_dob' => 41,'mail_range' => 42,'m_pre_dir' => 43,'m_street' => 44,'m_suffix' => 45,'m_post_dir' => 46,'m_pob' => 47,'m_rr_nbr' => 48,'m_rr_box' => 49,'m_scndry_rng' => 50,'m_scndry_des' => 51,'m_city' => 52,'m_state' => 53,'m_zip5' => 54,'m_zip4' => 55,'m_cntry_cd' => 56,'m_cc_filler' => 57,'m_cc' => 58,'m_county' => 59,'phys_range' => 60,'p_pre_dir' => 61,'p_street' => 62,'p_suffix' => 63,'p_post_dir' => 64,'p_pob' => 65,'p_rr_nbr' => 66,'p_rr_box' => 67,'p_scndry_rng' => 68,'p_scndry_des' => 69,'p_city' => 70,'p_state' => 71,'p_zip5' => 72,'p_zip4' => 73,'p_cntry_cd' => 74,'p_cc_filler' => 75,'p_cc' => 76,'p_county' => 77,'opt_out_cd' => 78,'asg_wgt' => 79,'asg_wgt_uom' => 80,'source_ctl_id' => 81,'raw_name' => 82,'branded_title_flag' => 83,'brand_code_1' => 84,'brand_date_1' => 85,'brand_state_1' => 86,'brand_code_2' => 87,'brand_date_2' => 88,'brand_state_2' => 89,'brand_code_3' => 90,'brand_date_3' => 91,'brand_state_3' => 92,'brand_code_4' => 93,'brand_date_4' => 94,'brand_state_4' => 95,'brand_code_5' => 96,'brand_date_5' => 97,'brand_state_5' => 98,'tod_flag' => 99,'model_class_code' => 100,'model_class' => 101,'min_door_count' => 102,'safety_type' => 103,'airbag_driver' => 104,'airbag_front_driver_side' => 105,'airbag_front_head_curtain' => 106,'airbag_front_pass' => 107,'airbag_front_pass_side' => 108,'airbags' => 109,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ALLOW'],['ENUM','LENGTHS'],['ALLOW'],['ENUM','LENGTHS'],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW'],['ENUM','LENGTHS'],['ALLOW'],['ENUM','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ENUM','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ENUM','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],['ENUM','LENGTHS'],['ALLOW'],['ENUM','LENGTHS'],['ALLOW'],['CAPS','ALLOW'],['ALLOW'],['ALLOW'],['ENUM','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CAPS','ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_append_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_append_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_append_state_origin(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_append_state_origin(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_append_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_file_typ(SALT311.StrType s0) := MakeFT_invalid_file_typ(s0);
EXPORT InValid_file_typ(SALT311.StrType s) := InValidFT_invalid_file_typ(s);
EXPORT InValidMessage_file_typ(UNSIGNED1 wh) := InValidMessageFT_invalid_file_typ(wh);


EXPORT Make_vin(SALT311.StrType s0) := MakeFT_invalid_vin(s0);
EXPORT InValid_vin(SALT311.StrType s) := InValidFT_invalid_vin(s);
EXPORT InValidMessage_vin(UNSIGNED1 wh) := InValidMessageFT_invalid_vin(wh);


EXPORT Make_vehicle_typ(SALT311.StrType s0) := MakeFT_invalid_vehicle_typ(s0);
EXPORT InValid_vehicle_typ(SALT311.StrType s) := InValidFT_invalid_vehicle_typ(s);
EXPORT InValidMessage_vehicle_typ(UNSIGNED1 wh) := InValidMessageFT_invalid_vehicle_typ(wh);


EXPORT Make_model_yr(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_model_yr(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_model_yr(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);


EXPORT Make_model_yr_ind(SALT311.StrType s0) := MakeFT_invalid_model_yr_ind(s0);
EXPORT InValid_model_yr_ind(SALT311.StrType s) := InValidFT_invalid_model_yr_ind(s);
EXPORT InValidMessage_model_yr_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_model_yr_ind(wh);


EXPORT Make_make(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_make(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_make(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_make_ind(SALT311.StrType s0) := MakeFT_invalid_model_yr_ind(s0);
EXPORT InValid_make_ind(SALT311.StrType s) := InValidFT_invalid_model_yr_ind(s);
EXPORT InValidMessage_make_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_model_yr_ind(wh);


EXPORT Make_series(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_series(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_series(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_series_ind(SALT311.StrType s0) := MakeFT_invalid_model_yr_ind(s0);
EXPORT InValid_series_ind(SALT311.StrType s) := InValidFT_invalid_model_yr_ind(s);
EXPORT InValidMessage_series_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_model_yr_ind(wh);


EXPORT Make_prime_color(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_prime_color(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_prime_color(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_second_color(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_second_color(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_second_color(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_body_style(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_body_style(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_body_style(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_body_style_ind(SALT311.StrType s0) := MakeFT_invalid_model_yr_ind(s0);
EXPORT InValid_body_style_ind(SALT311.StrType s) := InValidFT_invalid_model_yr_ind(s);
EXPORT InValidMessage_body_style_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_model_yr_ind(wh);


EXPORT Make_model(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_model(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_model(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_model_ind(SALT311.StrType s0) := MakeFT_invalid_model_yr_ind(s0);
EXPORT InValid_model_ind(SALT311.StrType s) := InValidFT_invalid_model_yr_ind(s);
EXPORT InValidMessage_model_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_model_yr_ind(wh);


EXPORT Make_weight(SALT311.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_weight(SALT311.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_weight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);


EXPORT Make_lengt(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_lengt(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_lengt(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_axle_cnt(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_axle_cnt(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_axle_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_plate_nbr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_plate_nbr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_plate_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_plate_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_plate_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_plate_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_prev_plate_nbr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_prev_plate_nbr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_prev_plate_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_prev_plate_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_prev_plate_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_prev_plate_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_plate_typ_cd(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_plate_typ_cd(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_plate_typ_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_mstr_src_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mstr_src_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mstr_src_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_reg_decal_nbr(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_reg_decal_nbr(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_reg_decal_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);


EXPORT Make_org_reg_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_org_reg_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_org_reg_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_reg_renew_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_reg_renew_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_reg_renew_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_reg_exp_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_reg_exp_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_reg_exp_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_title_nbr(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_title_nbr(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_title_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);


EXPORT Make_org_title_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_org_title_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_org_title_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_title_trans_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_title_trans_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_title_trans_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_name_typ_cd(SALT311.StrType s0) := MakeFT_invalid_name_typ_cd(s0);
EXPORT InValid_name_typ_cd(SALT311.StrType s) := InValidFT_invalid_name_typ_cd(s);
EXPORT InValidMessage_name_typ_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_typ_cd(wh);


EXPORT Make_owner_typ_cd(SALT311.StrType s0) := MakeFT_invalid_owner_typ_cd(s0);
EXPORT InValid_owner_typ_cd(SALT311.StrType s) := InValidFT_invalid_owner_typ_cd(s);
EXPORT InValidMessage_owner_typ_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_owner_typ_cd(wh);


EXPORT Make_first_nm(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_first_nm(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_first_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_middle_nm(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_middle_nm(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_middle_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_last_nm(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_last_nm(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_last_nm(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_name_suffix(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_name_suffix(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_prof_suffix(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_prof_suffix(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_prof_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_ind_ssn(SALT311.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ind_ssn(SALT311.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ind_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);


EXPORT Make_ind_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ind_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ind_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_mail_range(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mail_range(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mail_range(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_pre_dir(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_pre_dir(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_pre_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_street(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_street(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_street(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_suffix(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_suffix(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_post_dir(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_post_dir(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_post_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_pob(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_pob(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_pob(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_rr_nbr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_rr_nbr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_rr_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_rr_box(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_rr_box(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_rr_box(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_scndry_rng(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_scndry_rng(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_scndry_rng(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_scndry_des(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_scndry_des(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_scndry_des(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_city(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_city(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_m_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_m_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_m_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_m_zip5(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_m_zip5(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_m_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);


EXPORT Make_m_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_m_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_m_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);


EXPORT Make_m_cntry_cd(SALT311.StrType s0) := s0;
EXPORT InValid_m_cntry_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_m_cntry_cd(UNSIGNED1 wh) := '';


EXPORT Make_m_cc_filler(SALT311.StrType s0) := s0;
EXPORT InValid_m_cc_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_m_cc_filler(UNSIGNED1 wh) := '';


EXPORT Make_m_cc(SALT311.StrType s0) := MakeFT_invalid_cc(s0);
EXPORT InValid_m_cc(SALT311.StrType s) := InValidFT_invalid_cc(s);
EXPORT InValidMessage_m_cc(UNSIGNED1 wh) := InValidMessageFT_invalid_cc(wh);


EXPORT Make_m_county(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_m_county(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_m_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_phys_range(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_phys_range(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_phys_range(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_pre_dir(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_pre_dir(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_pre_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_street(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_street(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_street(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_suffix(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_suffix(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_post_dir(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_post_dir(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_post_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_pob(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_pob(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_pob(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_rr_nbr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_rr_nbr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_rr_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_rr_box(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_rr_box(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_rr_box(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_scndry_rng(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_scndry_rng(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_scndry_rng(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_scndry_des(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_scndry_des(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_scndry_des(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_city(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_p_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_p_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_p_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_p_zip5(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_p_zip5(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_p_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);


EXPORT Make_p_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_p_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_p_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);


EXPORT Make_p_cntry_cd(SALT311.StrType s0) := s0;
EXPORT InValid_p_cntry_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_cntry_cd(UNSIGNED1 wh) := '';


EXPORT Make_p_cc_filler(SALT311.StrType s0) := s0;
EXPORT InValid_p_cc_filler(SALT311.StrType s) := 0;
EXPORT InValidMessage_p_cc_filler(UNSIGNED1 wh) := '';


EXPORT Make_p_cc(SALT311.StrType s0) := MakeFT_invalid_cc(s0);
EXPORT InValid_p_cc(SALT311.StrType s) := InValidFT_invalid_cc(s);
EXPORT InValidMessage_p_cc(UNSIGNED1 wh) := InValidMessageFT_invalid_cc(wh);


EXPORT Make_p_county(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_county(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_opt_out_cd(SALT311.StrType s0) := MakeFT_invalid_opt_out_cd(s0);
EXPORT InValid_opt_out_cd(SALT311.StrType s) := InValidFT_invalid_opt_out_cd(s);
EXPORT InValidMessage_opt_out_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_opt_out_cd(wh);


EXPORT Make_asg_wgt(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_asg_wgt(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_asg_wgt(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_asg_wgt_uom(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_asg_wgt_uom(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_asg_wgt_uom(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_source_ctl_id(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_source_ctl_id(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_source_ctl_id(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);


EXPORT Make_raw_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_raw_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_raw_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_branded_title_flag(SALT311.StrType s0) := MakeFT_invalid_yes_no(s0);
EXPORT InValid_branded_title_flag(SALT311.StrType s) := InValidFT_invalid_yes_no(s);
EXPORT InValidMessage_branded_title_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_no(wh);


EXPORT Make_brand_code_1(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_brand_code_1(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_brand_code_1(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_brand_date_1(SALT311.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_brand_date_1(SALT311.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_brand_date_1(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);


EXPORT Make_brand_state_1(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_brand_state_1(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_brand_state_1(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_brand_code_2(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_brand_code_2(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_brand_code_2(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_brand_date_2(SALT311.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_brand_date_2(SALT311.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_brand_date_2(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);


EXPORT Make_brand_state_2(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_brand_state_2(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_brand_state_2(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_brand_code_3(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_brand_code_3(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_brand_code_3(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_brand_date_3(SALT311.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_brand_date_3(SALT311.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_brand_date_3(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);


EXPORT Make_brand_state_3(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_brand_state_3(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_brand_state_3(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_brand_code_4(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_brand_code_4(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_brand_code_4(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_brand_date_4(SALT311.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_brand_date_4(SALT311.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_brand_date_4(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);


EXPORT Make_brand_state_4(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_brand_state_4(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_brand_state_4(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_brand_code_5(SALT311.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_brand_code_5(SALT311.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_brand_code_5(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);


EXPORT Make_brand_date_5(SALT311.StrType s0) := MakeFT_invalid_date1(s0);
EXPORT InValid_brand_date_5(SALT311.StrType s) := InValidFT_invalid_date1(s);
EXPORT InValidMessage_brand_date_5(UNSIGNED1 wh) := InValidMessageFT_invalid_date1(wh);


EXPORT Make_brand_state_5(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_brand_state_5(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_brand_state_5(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);


EXPORT Make_tod_flag(SALT311.StrType s0) := MakeFT_invalid_yes_no(s0);
EXPORT InValid_tod_flag(SALT311.StrType s) := InValidFT_invalid_yes_no(s);
EXPORT InValidMessage_tod_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_yes_no(wh);


EXPORT Make_model_class_code(SALT311.StrType s0) := s0;
EXPORT InValid_model_class_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_model_class_code(UNSIGNED1 wh) := '';


EXPORT Make_model_class(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_model_class(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_model_class(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_min_door_count(SALT311.StrType s0) := MakeFT_invalid_min_door_count(s0);
EXPORT InValid_min_door_count(SALT311.StrType s) := InValidFT_invalid_min_door_count(s);
EXPORT InValidMessage_min_door_count(UNSIGNED1 wh) := InValidMessageFT_invalid_min_door_count(wh);


EXPORT Make_safety_type(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_safety_type(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_safety_type(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbag_driver(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbag_driver(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbag_driver(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbag_front_driver_side(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbag_front_driver_side(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbag_front_driver_side(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbag_front_head_curtain(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbag_front_head_curtain(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbag_front_head_curtain(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbag_front_pass(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbag_front_pass(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbag_front_pass(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbag_front_pass_side(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbag_front_pass_side(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbag_front_pass_side(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);


EXPORT Make_airbags(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_airbags(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_airbags(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_VehicleV2;
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
    BOOLEAN Diff_append_state_origin;
    BOOLEAN Diff_file_typ;
    BOOLEAN Diff_vin;
    BOOLEAN Diff_vehicle_typ;
    BOOLEAN Diff_model_yr;
    BOOLEAN Diff_model_yr_ind;
    BOOLEAN Diff_make;
    BOOLEAN Diff_make_ind;
    BOOLEAN Diff_series;
    BOOLEAN Diff_series_ind;
    BOOLEAN Diff_prime_color;
    BOOLEAN Diff_second_color;
    BOOLEAN Diff_body_style;
    BOOLEAN Diff_body_style_ind;
    BOOLEAN Diff_model;
    BOOLEAN Diff_model_ind;
    BOOLEAN Diff_weight;
    BOOLEAN Diff_lengt;
    BOOLEAN Diff_axle_cnt;
    BOOLEAN Diff_plate_nbr;
    BOOLEAN Diff_plate_state;
    BOOLEAN Diff_prev_plate_nbr;
    BOOLEAN Diff_prev_plate_state;
    BOOLEAN Diff_plate_typ_cd;
    BOOLEAN Diff_mstr_src_state;
    BOOLEAN Diff_reg_decal_nbr;
    BOOLEAN Diff_org_reg_dt;
    BOOLEAN Diff_reg_renew_dt;
    BOOLEAN Diff_reg_exp_dt;
    BOOLEAN Diff_title_nbr;
    BOOLEAN Diff_org_title_dt;
    BOOLEAN Diff_title_trans_dt;
    BOOLEAN Diff_name_typ_cd;
    BOOLEAN Diff_owner_typ_cd;
    BOOLEAN Diff_first_nm;
    BOOLEAN Diff_middle_nm;
    BOOLEAN Diff_last_nm;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_prof_suffix;
    BOOLEAN Diff_ind_ssn;
    BOOLEAN Diff_ind_dob;
    BOOLEAN Diff_mail_range;
    BOOLEAN Diff_m_pre_dir;
    BOOLEAN Diff_m_street;
    BOOLEAN Diff_m_suffix;
    BOOLEAN Diff_m_post_dir;
    BOOLEAN Diff_m_pob;
    BOOLEAN Diff_m_rr_nbr;
    BOOLEAN Diff_m_rr_box;
    BOOLEAN Diff_m_scndry_rng;
    BOOLEAN Diff_m_scndry_des;
    BOOLEAN Diff_m_city;
    BOOLEAN Diff_m_state;
    BOOLEAN Diff_m_zip5;
    BOOLEAN Diff_m_zip4;
    BOOLEAN Diff_m_cntry_cd;
    BOOLEAN Diff_m_cc_filler;
    BOOLEAN Diff_m_cc;
    BOOLEAN Diff_m_county;
    BOOLEAN Diff_phys_range;
    BOOLEAN Diff_p_pre_dir;
    BOOLEAN Diff_p_street;
    BOOLEAN Diff_p_suffix;
    BOOLEAN Diff_p_post_dir;
    BOOLEAN Diff_p_pob;
    BOOLEAN Diff_p_rr_nbr;
    BOOLEAN Diff_p_rr_box;
    BOOLEAN Diff_p_scndry_rng;
    BOOLEAN Diff_p_scndry_des;
    BOOLEAN Diff_p_city;
    BOOLEAN Diff_p_state;
    BOOLEAN Diff_p_zip5;
    BOOLEAN Diff_p_zip4;
    BOOLEAN Diff_p_cntry_cd;
    BOOLEAN Diff_p_cc_filler;
    BOOLEAN Diff_p_cc;
    BOOLEAN Diff_p_county;
    BOOLEAN Diff_opt_out_cd;
    BOOLEAN Diff_asg_wgt;
    BOOLEAN Diff_asg_wgt_uom;
    BOOLEAN Diff_source_ctl_id;
    BOOLEAN Diff_raw_name;
    BOOLEAN Diff_branded_title_flag;
    BOOLEAN Diff_brand_code_1;
    BOOLEAN Diff_brand_date_1;
    BOOLEAN Diff_brand_state_1;
    BOOLEAN Diff_brand_code_2;
    BOOLEAN Diff_brand_date_2;
    BOOLEAN Diff_brand_state_2;
    BOOLEAN Diff_brand_code_3;
    BOOLEAN Diff_brand_date_3;
    BOOLEAN Diff_brand_state_3;
    BOOLEAN Diff_brand_code_4;
    BOOLEAN Diff_brand_date_4;
    BOOLEAN Diff_brand_state_4;
    BOOLEAN Diff_brand_code_5;
    BOOLEAN Diff_brand_date_5;
    BOOLEAN Diff_brand_state_5;
    BOOLEAN Diff_tod_flag;
    BOOLEAN Diff_model_class_code;
    BOOLEAN Diff_model_class;
    BOOLEAN Diff_min_door_count;
    BOOLEAN Diff_safety_type;
    BOOLEAN Diff_airbag_driver;
    BOOLEAN Diff_airbag_front_driver_side;
    BOOLEAN Diff_airbag_front_head_curtain;
    BOOLEAN Diff_airbag_front_pass;
    BOOLEAN Diff_airbag_front_pass_side;
    BOOLEAN Diff_airbags;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_append_state_origin := le.append_state_origin <> ri.append_state_origin;
    SELF.Diff_file_typ := le.file_typ <> ri.file_typ;
    SELF.Diff_vin := le.vin <> ri.vin;
    SELF.Diff_vehicle_typ := le.vehicle_typ <> ri.vehicle_typ;
    SELF.Diff_model_yr := le.model_yr <> ri.model_yr;
    SELF.Diff_model_yr_ind := le.model_yr_ind <> ri.model_yr_ind;
    SELF.Diff_make := le.make <> ri.make;
    SELF.Diff_make_ind := le.make_ind <> ri.make_ind;
    SELF.Diff_series := le.series <> ri.series;
    SELF.Diff_series_ind := le.series_ind <> ri.series_ind;
    SELF.Diff_prime_color := le.prime_color <> ri.prime_color;
    SELF.Diff_second_color := le.second_color <> ri.second_color;
    SELF.Diff_body_style := le.body_style <> ri.body_style;
    SELF.Diff_body_style_ind := le.body_style_ind <> ri.body_style_ind;
    SELF.Diff_model := le.model <> ri.model;
    SELF.Diff_model_ind := le.model_ind <> ri.model_ind;
    SELF.Diff_weight := le.weight <> ri.weight;
    SELF.Diff_lengt := le.lengt <> ri.lengt;
    SELF.Diff_axle_cnt := le.axle_cnt <> ri.axle_cnt;
    SELF.Diff_plate_nbr := le.plate_nbr <> ri.plate_nbr;
    SELF.Diff_plate_state := le.plate_state <> ri.plate_state;
    SELF.Diff_prev_plate_nbr := le.prev_plate_nbr <> ri.prev_plate_nbr;
    SELF.Diff_prev_plate_state := le.prev_plate_state <> ri.prev_plate_state;
    SELF.Diff_plate_typ_cd := le.plate_typ_cd <> ri.plate_typ_cd;
    SELF.Diff_mstr_src_state := le.mstr_src_state <> ri.mstr_src_state;
    SELF.Diff_reg_decal_nbr := le.reg_decal_nbr <> ri.reg_decal_nbr;
    SELF.Diff_org_reg_dt := le.org_reg_dt <> ri.org_reg_dt;
    SELF.Diff_reg_renew_dt := le.reg_renew_dt <> ri.reg_renew_dt;
    SELF.Diff_reg_exp_dt := le.reg_exp_dt <> ri.reg_exp_dt;
    SELF.Diff_title_nbr := le.title_nbr <> ri.title_nbr;
    SELF.Diff_org_title_dt := le.org_title_dt <> ri.org_title_dt;
    SELF.Diff_title_trans_dt := le.title_trans_dt <> ri.title_trans_dt;
    SELF.Diff_name_typ_cd := le.name_typ_cd <> ri.name_typ_cd;
    SELF.Diff_owner_typ_cd := le.owner_typ_cd <> ri.owner_typ_cd;
    SELF.Diff_first_nm := le.first_nm <> ri.first_nm;
    SELF.Diff_middle_nm := le.middle_nm <> ri.middle_nm;
    SELF.Diff_last_nm := le.last_nm <> ri.last_nm;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_prof_suffix := le.prof_suffix <> ri.prof_suffix;
    SELF.Diff_ind_ssn := le.ind_ssn <> ri.ind_ssn;
    SELF.Diff_ind_dob := le.ind_dob <> ri.ind_dob;
    SELF.Diff_mail_range := le.mail_range <> ri.mail_range;
    SELF.Diff_m_pre_dir := le.m_pre_dir <> ri.m_pre_dir;
    SELF.Diff_m_street := le.m_street <> ri.m_street;
    SELF.Diff_m_suffix := le.m_suffix <> ri.m_suffix;
    SELF.Diff_m_post_dir := le.m_post_dir <> ri.m_post_dir;
    SELF.Diff_m_pob := le.m_pob <> ri.m_pob;
    SELF.Diff_m_rr_nbr := le.m_rr_nbr <> ri.m_rr_nbr;
    SELF.Diff_m_rr_box := le.m_rr_box <> ri.m_rr_box;
    SELF.Diff_m_scndry_rng := le.m_scndry_rng <> ri.m_scndry_rng;
    SELF.Diff_m_scndry_des := le.m_scndry_des <> ri.m_scndry_des;
    SELF.Diff_m_city := le.m_city <> ri.m_city;
    SELF.Diff_m_state := le.m_state <> ri.m_state;
    SELF.Diff_m_zip5 := le.m_zip5 <> ri.m_zip5;
    SELF.Diff_m_zip4 := le.m_zip4 <> ri.m_zip4;
    SELF.Diff_m_cntry_cd := le.m_cntry_cd <> ri.m_cntry_cd;
    SELF.Diff_m_cc_filler := le.m_cc_filler <> ri.m_cc_filler;
    SELF.Diff_m_cc := le.m_cc <> ri.m_cc;
    SELF.Diff_m_county := le.m_county <> ri.m_county;
    SELF.Diff_phys_range := le.phys_range <> ri.phys_range;
    SELF.Diff_p_pre_dir := le.p_pre_dir <> ri.p_pre_dir;
    SELF.Diff_p_street := le.p_street <> ri.p_street;
    SELF.Diff_p_suffix := le.p_suffix <> ri.p_suffix;
    SELF.Diff_p_post_dir := le.p_post_dir <> ri.p_post_dir;
    SELF.Diff_p_pob := le.p_pob <> ri.p_pob;
    SELF.Diff_p_rr_nbr := le.p_rr_nbr <> ri.p_rr_nbr;
    SELF.Diff_p_rr_box := le.p_rr_box <> ri.p_rr_box;
    SELF.Diff_p_scndry_rng := le.p_scndry_rng <> ri.p_scndry_rng;
    SELF.Diff_p_scndry_des := le.p_scndry_des <> ri.p_scndry_des;
    SELF.Diff_p_city := le.p_city <> ri.p_city;
    SELF.Diff_p_state := le.p_state <> ri.p_state;
    SELF.Diff_p_zip5 := le.p_zip5 <> ri.p_zip5;
    SELF.Diff_p_zip4 := le.p_zip4 <> ri.p_zip4;
    SELF.Diff_p_cntry_cd := le.p_cntry_cd <> ri.p_cntry_cd;
    SELF.Diff_p_cc_filler := le.p_cc_filler <> ri.p_cc_filler;
    SELF.Diff_p_cc := le.p_cc <> ri.p_cc;
    SELF.Diff_p_county := le.p_county <> ri.p_county;
    SELF.Diff_opt_out_cd := le.opt_out_cd <> ri.opt_out_cd;
    SELF.Diff_asg_wgt := le.asg_wgt <> ri.asg_wgt;
    SELF.Diff_asg_wgt_uom := le.asg_wgt_uom <> ri.asg_wgt_uom;
    SELF.Diff_source_ctl_id := le.source_ctl_id <> ri.source_ctl_id;
    SELF.Diff_raw_name := le.raw_name <> ri.raw_name;
    SELF.Diff_branded_title_flag := le.branded_title_flag <> ri.branded_title_flag;
    SELF.Diff_brand_code_1 := le.brand_code_1 <> ri.brand_code_1;
    SELF.Diff_brand_date_1 := le.brand_date_1 <> ri.brand_date_1;
    SELF.Diff_brand_state_1 := le.brand_state_1 <> ri.brand_state_1;
    SELF.Diff_brand_code_2 := le.brand_code_2 <> ri.brand_code_2;
    SELF.Diff_brand_date_2 := le.brand_date_2 <> ri.brand_date_2;
    SELF.Diff_brand_state_2 := le.brand_state_2 <> ri.brand_state_2;
    SELF.Diff_brand_code_3 := le.brand_code_3 <> ri.brand_code_3;
    SELF.Diff_brand_date_3 := le.brand_date_3 <> ri.brand_date_3;
    SELF.Diff_brand_state_3 := le.brand_state_3 <> ri.brand_state_3;
    SELF.Diff_brand_code_4 := le.brand_code_4 <> ri.brand_code_4;
    SELF.Diff_brand_date_4 := le.brand_date_4 <> ri.brand_date_4;
    SELF.Diff_brand_state_4 := le.brand_state_4 <> ri.brand_state_4;
    SELF.Diff_brand_code_5 := le.brand_code_5 <> ri.brand_code_5;
    SELF.Diff_brand_date_5 := le.brand_date_5 <> ri.brand_date_5;
    SELF.Diff_brand_state_5 := le.brand_state_5 <> ri.brand_state_5;
    SELF.Diff_tod_flag := le.tod_flag <> ri.tod_flag;
    SELF.Diff_model_class_code := le.model_class_code <> ri.model_class_code;
    SELF.Diff_model_class := le.model_class <> ri.model_class;
    SELF.Diff_min_door_count := le.min_door_count <> ri.min_door_count;
    SELF.Diff_safety_type := le.safety_type <> ri.safety_type;
    SELF.Diff_airbag_driver := le.airbag_driver <> ri.airbag_driver;
    SELF.Diff_airbag_front_driver_side := le.airbag_front_driver_side <> ri.airbag_front_driver_side;
    SELF.Diff_airbag_front_head_curtain := le.airbag_front_head_curtain <> ri.airbag_front_head_curtain;
    SELF.Diff_airbag_front_pass := le.airbag_front_pass <> ri.airbag_front_pass;
    SELF.Diff_airbag_front_pass_side := le.airbag_front_pass_side <> ri.airbag_front_pass_side;
    SELF.Diff_airbags := le.airbags <> ri.airbags;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.append_state_origin;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_append_state_origin,1,0)+ IF( SELF.Diff_file_typ,1,0)+ IF( SELF.Diff_vin,1,0)+ IF( SELF.Diff_vehicle_typ,1,0)+ IF( SELF.Diff_model_yr,1,0)+ IF( SELF.Diff_model_yr_ind,1,0)+ IF( SELF.Diff_make,1,0)+ IF( SELF.Diff_make_ind,1,0)+ IF( SELF.Diff_series,1,0)+ IF( SELF.Diff_series_ind,1,0)+ IF( SELF.Diff_prime_color,1,0)+ IF( SELF.Diff_second_color,1,0)+ IF( SELF.Diff_body_style,1,0)+ IF( SELF.Diff_body_style_ind,1,0)+ IF( SELF.Diff_model,1,0)+ IF( SELF.Diff_model_ind,1,0)+ IF( SELF.Diff_weight,1,0)+ IF( SELF.Diff_lengt,1,0)+ IF( SELF.Diff_axle_cnt,1,0)+ IF( SELF.Diff_plate_nbr,1,0)+ IF( SELF.Diff_plate_state,1,0)+ IF( SELF.Diff_prev_plate_nbr,1,0)+ IF( SELF.Diff_prev_plate_state,1,0)+ IF( SELF.Diff_plate_typ_cd,1,0)+ IF( SELF.Diff_mstr_src_state,1,0)+ IF( SELF.Diff_reg_decal_nbr,1,0)+ IF( SELF.Diff_org_reg_dt,1,0)+ IF( SELF.Diff_reg_renew_dt,1,0)+ IF( SELF.Diff_reg_exp_dt,1,0)+ IF( SELF.Diff_title_nbr,1,0)+ IF( SELF.Diff_org_title_dt,1,0)+ IF( SELF.Diff_title_trans_dt,1,0)+ IF( SELF.Diff_name_typ_cd,1,0)+ IF( SELF.Diff_owner_typ_cd,1,0)+ IF( SELF.Diff_first_nm,1,0)+ IF( SELF.Diff_middle_nm,1,0)+ IF( SELF.Diff_last_nm,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_prof_suffix,1,0)+ IF( SELF.Diff_ind_ssn,1,0)+ IF( SELF.Diff_ind_dob,1,0)+ IF( SELF.Diff_mail_range,1,0)+ IF( SELF.Diff_m_pre_dir,1,0)+ IF( SELF.Diff_m_street,1,0)+ IF( SELF.Diff_m_suffix,1,0)+ IF( SELF.Diff_m_post_dir,1,0)+ IF( SELF.Diff_m_pob,1,0)+ IF( SELF.Diff_m_rr_nbr,1,0)+ IF( SELF.Diff_m_rr_box,1,0)+ IF( SELF.Diff_m_scndry_rng,1,0)+ IF( SELF.Diff_m_scndry_des,1,0)+ IF( SELF.Diff_m_city,1,0)+ IF( SELF.Diff_m_state,1,0)+ IF( SELF.Diff_m_zip5,1,0)+ IF( SELF.Diff_m_zip4,1,0)+ IF( SELF.Diff_m_cntry_cd,1,0)+ IF( SELF.Diff_m_cc_filler,1,0)+ IF( SELF.Diff_m_cc,1,0)+ IF( SELF.Diff_m_county,1,0)+ IF( SELF.Diff_phys_range,1,0)+ IF( SELF.Diff_p_pre_dir,1,0)+ IF( SELF.Diff_p_street,1,0)+ IF( SELF.Diff_p_suffix,1,0)+ IF( SELF.Diff_p_post_dir,1,0)+ IF( SELF.Diff_p_pob,1,0)+ IF( SELF.Diff_p_rr_nbr,1,0)+ IF( SELF.Diff_p_rr_box,1,0)+ IF( SELF.Diff_p_scndry_rng,1,0)+ IF( SELF.Diff_p_scndry_des,1,0)+ IF( SELF.Diff_p_city,1,0)+ IF( SELF.Diff_p_state,1,0)+ IF( SELF.Diff_p_zip5,1,0)+ IF( SELF.Diff_p_zip4,1,0)+ IF( SELF.Diff_p_cntry_cd,1,0)+ IF( SELF.Diff_p_cc_filler,1,0)+ IF( SELF.Diff_p_cc,1,0)+ IF( SELF.Diff_p_county,1,0)+ IF( SELF.Diff_opt_out_cd,1,0)+ IF( SELF.Diff_asg_wgt,1,0)+ IF( SELF.Diff_asg_wgt_uom,1,0)+ IF( SELF.Diff_source_ctl_id,1,0)+ IF( SELF.Diff_raw_name,1,0)+ IF( SELF.Diff_branded_title_flag,1,0)+ IF( SELF.Diff_brand_code_1,1,0)+ IF( SELF.Diff_brand_date_1,1,0)+ IF( SELF.Diff_brand_state_1,1,0)+ IF( SELF.Diff_brand_code_2,1,0)+ IF( SELF.Diff_brand_date_2,1,0)+ IF( SELF.Diff_brand_state_2,1,0)+ IF( SELF.Diff_brand_code_3,1,0)+ IF( SELF.Diff_brand_date_3,1,0)+ IF( SELF.Diff_brand_state_3,1,0)+ IF( SELF.Diff_brand_code_4,1,0)+ IF( SELF.Diff_brand_date_4,1,0)+ IF( SELF.Diff_brand_state_4,1,0)+ IF( SELF.Diff_brand_code_5,1,0)+ IF( SELF.Diff_brand_date_5,1,0)+ IF( SELF.Diff_brand_state_5,1,0)+ IF( SELF.Diff_tod_flag,1,0)+ IF( SELF.Diff_model_class_code,1,0)+ IF( SELF.Diff_model_class,1,0)+ IF( SELF.Diff_min_door_count,1,0)+ IF( SELF.Diff_safety_type,1,0)+ IF( SELF.Diff_airbag_driver,1,0)+ IF( SELF.Diff_airbag_front_driver_side,1,0)+ IF( SELF.Diff_airbag_front_head_curtain,1,0)+ IF( SELF.Diff_airbag_front_pass,1,0)+ IF( SELF.Diff_airbag_front_pass_side,1,0)+ IF( SELF.Diff_airbags,1,0);
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
    Count_Diff_append_state_origin := COUNT(GROUP,%Closest%.Diff_append_state_origin);
    Count_Diff_file_typ := COUNT(GROUP,%Closest%.Diff_file_typ);
    Count_Diff_vin := COUNT(GROUP,%Closest%.Diff_vin);
    Count_Diff_vehicle_typ := COUNT(GROUP,%Closest%.Diff_vehicle_typ);
    Count_Diff_model_yr := COUNT(GROUP,%Closest%.Diff_model_yr);
    Count_Diff_model_yr_ind := COUNT(GROUP,%Closest%.Diff_model_yr_ind);
    Count_Diff_make := COUNT(GROUP,%Closest%.Diff_make);
    Count_Diff_make_ind := COUNT(GROUP,%Closest%.Diff_make_ind);
    Count_Diff_series := COUNT(GROUP,%Closest%.Diff_series);
    Count_Diff_series_ind := COUNT(GROUP,%Closest%.Diff_series_ind);
    Count_Diff_prime_color := COUNT(GROUP,%Closest%.Diff_prime_color);
    Count_Diff_second_color := COUNT(GROUP,%Closest%.Diff_second_color);
    Count_Diff_body_style := COUNT(GROUP,%Closest%.Diff_body_style);
    Count_Diff_body_style_ind := COUNT(GROUP,%Closest%.Diff_body_style_ind);
    Count_Diff_model := COUNT(GROUP,%Closest%.Diff_model);
    Count_Diff_model_ind := COUNT(GROUP,%Closest%.Diff_model_ind);
    Count_Diff_weight := COUNT(GROUP,%Closest%.Diff_weight);
    Count_Diff_lengt := COUNT(GROUP,%Closest%.Diff_lengt);
    Count_Diff_axle_cnt := COUNT(GROUP,%Closest%.Diff_axle_cnt);
    Count_Diff_plate_nbr := COUNT(GROUP,%Closest%.Diff_plate_nbr);
    Count_Diff_plate_state := COUNT(GROUP,%Closest%.Diff_plate_state);
    Count_Diff_prev_plate_nbr := COUNT(GROUP,%Closest%.Diff_prev_plate_nbr);
    Count_Diff_prev_plate_state := COUNT(GROUP,%Closest%.Diff_prev_plate_state);
    Count_Diff_plate_typ_cd := COUNT(GROUP,%Closest%.Diff_plate_typ_cd);
    Count_Diff_mstr_src_state := COUNT(GROUP,%Closest%.Diff_mstr_src_state);
    Count_Diff_reg_decal_nbr := COUNT(GROUP,%Closest%.Diff_reg_decal_nbr);
    Count_Diff_org_reg_dt := COUNT(GROUP,%Closest%.Diff_org_reg_dt);
    Count_Diff_reg_renew_dt := COUNT(GROUP,%Closest%.Diff_reg_renew_dt);
    Count_Diff_reg_exp_dt := COUNT(GROUP,%Closest%.Diff_reg_exp_dt);
    Count_Diff_title_nbr := COUNT(GROUP,%Closest%.Diff_title_nbr);
    Count_Diff_org_title_dt := COUNT(GROUP,%Closest%.Diff_org_title_dt);
    Count_Diff_title_trans_dt := COUNT(GROUP,%Closest%.Diff_title_trans_dt);
    Count_Diff_name_typ_cd := COUNT(GROUP,%Closest%.Diff_name_typ_cd);
    Count_Diff_owner_typ_cd := COUNT(GROUP,%Closest%.Diff_owner_typ_cd);
    Count_Diff_first_nm := COUNT(GROUP,%Closest%.Diff_first_nm);
    Count_Diff_middle_nm := COUNT(GROUP,%Closest%.Diff_middle_nm);
    Count_Diff_last_nm := COUNT(GROUP,%Closest%.Diff_last_nm);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_prof_suffix := COUNT(GROUP,%Closest%.Diff_prof_suffix);
    Count_Diff_ind_ssn := COUNT(GROUP,%Closest%.Diff_ind_ssn);
    Count_Diff_ind_dob := COUNT(GROUP,%Closest%.Diff_ind_dob);
    Count_Diff_mail_range := COUNT(GROUP,%Closest%.Diff_mail_range);
    Count_Diff_m_pre_dir := COUNT(GROUP,%Closest%.Diff_m_pre_dir);
    Count_Diff_m_street := COUNT(GROUP,%Closest%.Diff_m_street);
    Count_Diff_m_suffix := COUNT(GROUP,%Closest%.Diff_m_suffix);
    Count_Diff_m_post_dir := COUNT(GROUP,%Closest%.Diff_m_post_dir);
    Count_Diff_m_pob := COUNT(GROUP,%Closest%.Diff_m_pob);
    Count_Diff_m_rr_nbr := COUNT(GROUP,%Closest%.Diff_m_rr_nbr);
    Count_Diff_m_rr_box := COUNT(GROUP,%Closest%.Diff_m_rr_box);
    Count_Diff_m_scndry_rng := COUNT(GROUP,%Closest%.Diff_m_scndry_rng);
    Count_Diff_m_scndry_des := COUNT(GROUP,%Closest%.Diff_m_scndry_des);
    Count_Diff_m_city := COUNT(GROUP,%Closest%.Diff_m_city);
    Count_Diff_m_state := COUNT(GROUP,%Closest%.Diff_m_state);
    Count_Diff_m_zip5 := COUNT(GROUP,%Closest%.Diff_m_zip5);
    Count_Diff_m_zip4 := COUNT(GROUP,%Closest%.Diff_m_zip4);
    Count_Diff_m_cntry_cd := COUNT(GROUP,%Closest%.Diff_m_cntry_cd);
    Count_Diff_m_cc_filler := COUNT(GROUP,%Closest%.Diff_m_cc_filler);
    Count_Diff_m_cc := COUNT(GROUP,%Closest%.Diff_m_cc);
    Count_Diff_m_county := COUNT(GROUP,%Closest%.Diff_m_county);
    Count_Diff_phys_range := COUNT(GROUP,%Closest%.Diff_phys_range);
    Count_Diff_p_pre_dir := COUNT(GROUP,%Closest%.Diff_p_pre_dir);
    Count_Diff_p_street := COUNT(GROUP,%Closest%.Diff_p_street);
    Count_Diff_p_suffix := COUNT(GROUP,%Closest%.Diff_p_suffix);
    Count_Diff_p_post_dir := COUNT(GROUP,%Closest%.Diff_p_post_dir);
    Count_Diff_p_pob := COUNT(GROUP,%Closest%.Diff_p_pob);
    Count_Diff_p_rr_nbr := COUNT(GROUP,%Closest%.Diff_p_rr_nbr);
    Count_Diff_p_rr_box := COUNT(GROUP,%Closest%.Diff_p_rr_box);
    Count_Diff_p_scndry_rng := COUNT(GROUP,%Closest%.Diff_p_scndry_rng);
    Count_Diff_p_scndry_des := COUNT(GROUP,%Closest%.Diff_p_scndry_des);
    Count_Diff_p_city := COUNT(GROUP,%Closest%.Diff_p_city);
    Count_Diff_p_state := COUNT(GROUP,%Closest%.Diff_p_state);
    Count_Diff_p_zip5 := COUNT(GROUP,%Closest%.Diff_p_zip5);
    Count_Diff_p_zip4 := COUNT(GROUP,%Closest%.Diff_p_zip4);
    Count_Diff_p_cntry_cd := COUNT(GROUP,%Closest%.Diff_p_cntry_cd);
    Count_Diff_p_cc_filler := COUNT(GROUP,%Closest%.Diff_p_cc_filler);
    Count_Diff_p_cc := COUNT(GROUP,%Closest%.Diff_p_cc);
    Count_Diff_p_county := COUNT(GROUP,%Closest%.Diff_p_county);
    Count_Diff_opt_out_cd := COUNT(GROUP,%Closest%.Diff_opt_out_cd);
    Count_Diff_asg_wgt := COUNT(GROUP,%Closest%.Diff_asg_wgt);
    Count_Diff_asg_wgt_uom := COUNT(GROUP,%Closest%.Diff_asg_wgt_uom);
    Count_Diff_source_ctl_id := COUNT(GROUP,%Closest%.Diff_source_ctl_id);
    Count_Diff_raw_name := COUNT(GROUP,%Closest%.Diff_raw_name);
    Count_Diff_branded_title_flag := COUNT(GROUP,%Closest%.Diff_branded_title_flag);
    Count_Diff_brand_code_1 := COUNT(GROUP,%Closest%.Diff_brand_code_1);
    Count_Diff_brand_date_1 := COUNT(GROUP,%Closest%.Diff_brand_date_1);
    Count_Diff_brand_state_1 := COUNT(GROUP,%Closest%.Diff_brand_state_1);
    Count_Diff_brand_code_2 := COUNT(GROUP,%Closest%.Diff_brand_code_2);
    Count_Diff_brand_date_2 := COUNT(GROUP,%Closest%.Diff_brand_date_2);
    Count_Diff_brand_state_2 := COUNT(GROUP,%Closest%.Diff_brand_state_2);
    Count_Diff_brand_code_3 := COUNT(GROUP,%Closest%.Diff_brand_code_3);
    Count_Diff_brand_date_3 := COUNT(GROUP,%Closest%.Diff_brand_date_3);
    Count_Diff_brand_state_3 := COUNT(GROUP,%Closest%.Diff_brand_state_3);
    Count_Diff_brand_code_4 := COUNT(GROUP,%Closest%.Diff_brand_code_4);
    Count_Diff_brand_date_4 := COUNT(GROUP,%Closest%.Diff_brand_date_4);
    Count_Diff_brand_state_4 := COUNT(GROUP,%Closest%.Diff_brand_state_4);
    Count_Diff_brand_code_5 := COUNT(GROUP,%Closest%.Diff_brand_code_5);
    Count_Diff_brand_date_5 := COUNT(GROUP,%Closest%.Diff_brand_date_5);
    Count_Diff_brand_state_5 := COUNT(GROUP,%Closest%.Diff_brand_state_5);
    Count_Diff_tod_flag := COUNT(GROUP,%Closest%.Diff_tod_flag);
    Count_Diff_model_class_code := COUNT(GROUP,%Closest%.Diff_model_class_code);
    Count_Diff_model_class := COUNT(GROUP,%Closest%.Diff_model_class);
    Count_Diff_min_door_count := COUNT(GROUP,%Closest%.Diff_min_door_count);
    Count_Diff_safety_type := COUNT(GROUP,%Closest%.Diff_safety_type);
    Count_Diff_airbag_driver := COUNT(GROUP,%Closest%.Diff_airbag_driver);
    Count_Diff_airbag_front_driver_side := COUNT(GROUP,%Closest%.Diff_airbag_front_driver_side);
    Count_Diff_airbag_front_head_curtain := COUNT(GROUP,%Closest%.Diff_airbag_front_head_curtain);
    Count_Diff_airbag_front_pass := COUNT(GROUP,%Closest%.Diff_airbag_front_pass);
    Count_Diff_airbag_front_pass_side := COUNT(GROUP,%Closest%.Diff_airbag_front_pass_side);
    Count_Diff_airbags := COUNT(GROUP,%Closest%.Diff_airbags);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
