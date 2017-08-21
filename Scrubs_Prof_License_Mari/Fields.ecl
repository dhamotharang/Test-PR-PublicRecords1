
IMPORT ut,SALT31;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'nums','lowercase','uppercase','alphas','lowercaseandnums','uppercaseandnums','alphasandnums','allupper','allupperandnums','allalphaandnums','blank','invalid_blank','invalid_date','invalid_primary_key','invalid_create_dte','invalid_last_upd_dte','invalid_stamp_dte','invalid_gen_nbr','invalid_std_prof_cd','invalid_std_prof_desc','invalid_std_source_upd','invalid_std_source_desc','invalid_type_cd','invalid_name_org_prefx','invalid_name_org','invalid_name_org_sufx','invalid_store_nbr','invalid_name_dba_prefx','invalid_name_dba','invalid_name_dba_sufx','invalid_store_nbr_dba','invalid_dba_flag','invalid_name_office','invalid_office_parse','invalid_name','invalid_gender','invalid_prov_stat','invalid_credential','invalid_license_nbr','invalid_prev_license_nbr','invalid_prev_license_type','invalid_license_state','invalid_raw_license_type','invalid_std_license_type','invalid_std_license_desc','invalid_raw_license_status','invalid_std_license_status','invalid_std_status_desc','invalid_renewal_dte','invalid_active_flag','invalid_ssn_taxid_1','invalid_tax_type_1','invalid_ssn_taxid_2','invalid_tax_type_2','invalid_fed_rssd','invalid_addr_bus_ind','invalid_name_format','invalid_name_org_orig','invalid_name_dba_orig','invalid_name_mari_org','invalid_name_mari_dba','invalid_phone_number','invalid_address','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_county','invalid_country','invalid_sud_key','invalid_ooc_ind','invalid_addr_mail_ind','invalid_license_nbr_contact','invalid_email','invalid_url','invalid_bk_class','invalid_bk_class_desc','invalid_charter','invalid_origin_cd','invalid_origin_cd_desc','invalid_disp_type_cd','invalid_disp_type_desc','invalid_reg_agent','invalid_regulator','invalid_hqtr_name','invalid_domestic_off_nbr','invalid_foreign_off_nbr','invalid_hcr_rssd','invalid_affil_type_cd','invalid_genlink','invalid_research_ind','invalid_docket_id','invalid_mltreckey','invalid_cmc_slpk','invalid_pcmc_slpk','invalid_affil_key','invalid_provnote','invalid_viol_desc','invalid_displinary_action','invalid_misc_other_id','invalid_misc_other_type','invalid_cont_education_ernd','invalid_cont_education_req','invalid_cont_education_term','invalid_addl_license_spec','invalid_race_cd','invalid_std_race_cd','invalid_agency_status','invalid_prev_primary_key','invalid_prev_mltreckey','invalid_prev_cmc_slpk','invalid_prev_pcmc_slpk','invalid_license_id','invalid_nmls_id','invalid_foreign_nmls_id','invalid_location_type','invalid_off_license_nbr_type','invalid_brkr_license_nbr','invalid_brkr_license_nbr_type','invalid_agency_id','invalid_business_type','invalid_name_type','invalid_is_authorized','invalid_federal_regulator');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'nums' => 1,'lowercase' => 2,'uppercase' => 3,'alphas' => 4,'lowercaseandnums' => 5,'uppercaseandnums' => 6,'alphasandnums' => 7,'allupper' => 8,'allupperandnums' => 9,'allalphaandnums' => 10,'blank' => 11,'invalid_blank' => 12,'invalid_date' => 13,'invalid_primary_key' => 14,'invalid_create_dte' => 15,'invalid_last_upd_dte' => 16,'invalid_stamp_dte' => 17,'invalid_gen_nbr' => 18,'invalid_std_prof_cd' => 19,'invalid_std_prof_desc' => 20,'invalid_std_source_upd' => 21,'invalid_std_source_desc' => 22,'invalid_type_cd' => 23,'invalid_name_org_prefx' => 24,'invalid_name_org' => 25,'invalid_name_org_sufx' => 26,'invalid_store_nbr' => 27,'invalid_name_dba_prefx' => 28,'invalid_name_dba' => 29,'invalid_name_dba_sufx' => 30,'invalid_store_nbr_dba' => 31,'invalid_dba_flag' => 32,'invalid_name_office' => 33,'invalid_office_parse' => 34,'invalid_name' => 35,'invalid_gender' => 36,'invalid_prov_stat' => 37,'invalid_credential' => 38,'invalid_license_nbr' => 39,'invalid_prev_license_nbr' => 40,'invalid_prev_license_type' => 41,'invalid_license_state' => 42,'invalid_raw_license_type' => 43,'invalid_std_license_type' => 44,'invalid_std_license_desc' => 45,'invalid_raw_license_status' => 46,'invalid_std_license_status' => 47,'invalid_std_status_desc' => 48,'invalid_renewal_dte' => 49,'invalid_active_flag' => 50,'invalid_ssn_taxid_1' => 51,'invalid_tax_type_1' => 52,'invalid_ssn_taxid_2' => 53,'invalid_tax_type_2' => 54,'invalid_fed_rssd' => 55,'invalid_addr_bus_ind' => 56,'invalid_name_format' => 57,'invalid_name_org_orig' => 58,'invalid_name_dba_orig' => 59,'invalid_name_mari_org' => 60,'invalid_name_mari_dba' => 61,'invalid_phone_number' => 62,'invalid_address' => 63,'invalid_city' => 64,'invalid_state' => 65,'invalid_zip5' => 66,'invalid_zip4' => 67,'invalid_county' => 68,'invalid_country' => 69,'invalid_sud_key' => 70,'invalid_ooc_ind' => 71,'invalid_addr_mail_ind' => 72,'invalid_license_nbr_contact' => 73,'invalid_email' => 74,'invalid_url' => 75,'invalid_bk_class' => 76,'invalid_bk_class_desc' => 77,'invalid_charter' => 78,'invalid_origin_cd' => 79,'invalid_origin_cd_desc' => 80,'invalid_disp_type_cd' => 81,'invalid_disp_type_desc' => 82,'invalid_reg_agent' => 83,'invalid_regulator' => 84,'invalid_hqtr_name' => 85,'invalid_domestic_off_nbr' => 86,'invalid_foreign_off_nbr' => 87,'invalid_hcr_rssd' => 88,'invalid_affil_type_cd' => 89,'invalid_genlink' => 90,'invalid_research_ind' => 91,'invalid_docket_id' => 92,'invalid_mltreckey' => 93,'invalid_cmc_slpk' => 94,'invalid_pcmc_slpk' => 95,'invalid_affil_key' => 96,'invalid_provnote' => 97,'invalid_viol_desc' => 98,'invalid_displinary_action' => 99,'invalid_misc_other_id' => 100,'invalid_misc_other_type' => 101,'invalid_cont_education_ernd' => 102,'invalid_cont_education_req' => 103,'invalid_cont_education_term' => 104,'invalid_addl_license_spec' => 105,'invalid_race_cd' => 106,'invalid_std_race_cd' => 107,'invalid_agency_status' => 108,'invalid_prev_primary_key' => 109,'invalid_prev_mltreckey' => 110,'invalid_prev_cmc_slpk' => 111,'invalid_prev_pcmc_slpk' => 112,'invalid_license_id' => 113,'invalid_nmls_id' => 114,'invalid_foreign_nmls_id' => 115,'invalid_location_type' => 116,'invalid_off_license_nbr_type' => 117,'invalid_brkr_license_nbr' => 118,'invalid_brkr_license_nbr_type' => 119,'invalid_agency_id' => 120,'invalid_business_type' => 121,'invalid_name_type' => 122,'invalid_is_authorized' => 123,'invalid_federal_regulator' => 124,0);
EXPORT MakeFT_nums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_nums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_nums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lowercase(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercase(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'abcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_lowercase(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_uppercase(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercase(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_uppercase(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_alphas(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphas(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_alphas(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lowercaseandnums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_lowercaseandnums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'abcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_lowercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyz0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_uppercaseandnums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_uppercaseandnums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_uppercaseandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_alphasandnums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alphasandnums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_alphasandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_allupper(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupper(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©'))));
EXPORT InValidMessageFT_allupper(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_allupperandnums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allupperandnums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789'))));
EXPORT InValidMessageFT_allupperandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_allalphaandnums(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_allalphaandnums(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_allalphaandnums(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_blank(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_blank(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_blank(SALT31.StrType s0) := FUNCTION
  RETURN  MakeFT_blank(s0);
END;
EXPORT InValidFT_invalid_blank(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_date(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.NotLength('0,8'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_primary_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_primary_key(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_primary_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_create_dte(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_create_dte(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 19));
EXPORT InValidMessageFT_invalid_create_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('8,19'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_last_upd_dte(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_last_upd_dte(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 19));
EXPORT InValidMessageFT_invalid_last_upd_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('8,19'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_stamp_dte(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_stamp_dte(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 19));
EXPORT InValidMessageFT_invalid_stamp_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('8,19'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_gen_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'C0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_gen_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'C0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 9 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_gen_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('C0123456789'),SALT31.HygieneErrors.NotLength('0,9..10'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_prof_cd(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_prof_cd(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_invalid_std_prof_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_prof_desc(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_prof_desc(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['MORTGAGE LENDERS','APPRAISERS','']);
EXPORT InValidMessageFT_invalid_std_prof_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('MORTGAGE LENDERS|APPRAISERS|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_source_upd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ST0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_std_source_upd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ST0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_std_source_upd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ST0123456789'),SALT31.HygieneErrors.NotLength('5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_source_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ &-'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' &-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_std_source_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ &-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 39 OR LENGTH(TRIM(s)) = 47));
EXPORT InValidMessageFT_invalid_std_source_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ &-'),SALT31.HygieneErrors.NotLength('0,39,47'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_type_cd(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_cd(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['MD','GR',''],~(LENGTH(TRIM(s)) = 2 or LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('MD|GR|'),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_org_prefx(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'THE()'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,'()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name_org_prefx(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'THE()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_name_org_prefx(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('THE()'),SALT31.HygieneErrors.NotLength('0,3,5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_org(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -=~"&$\'./\\()#{},+@!_|^:%`?'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -=~"&$\'./\\()#{},+@!_|^:%`?',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupperandnums(s2);
END;
EXPORT InValidFT_invalid_name_org(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -=~"&$\'./\\()#{},+@!_|^:%`?'))));
EXPORT InValidMessageFT_invalid_name_org(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -=~"&$\'./\\()#{},+@!_|^:%`?'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_org_sufx(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.'); // Only allow valid symbols
	s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ,-.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_name_org_sufx(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_name_org_sufx(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.'),SALT31.HygieneErrors.NotLength('0..15'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_store_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_store_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_store_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('0..8'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_dba_prefx(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'THE()'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,'()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name_dba_prefx(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'THE()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_name_dba_prefx(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('THE()'),SALT31.HygieneErrors.NotLength('0,3,5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_dba(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -"&\'./()#{}<>,+!$@`;|%'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -"&\'./()#{}<>,+!$@`;|%',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_name_dba(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -"&\'./()#{}<>,+!$@`;|%'))));
EXPORT InValidMessageFT_invalid_name_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -"&\'./()#{}<>,+!$@`;|%'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_dba_sufx(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.'); // Only allow valid symbols
	s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_name_dba_sufx(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -.'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_invalid_name_dba_sufx(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -.'),SALT31.HygieneErrors.NotLength('0..5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_store_nbr_dba(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_store_nbr_dba(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_store_nbr_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('0..10'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_dba_flag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dba_flag(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01'))));
EXPORT InValidMessageFT_invalid_dba_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('01'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_office(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&\'./\\()#*^{}<>,@+$!Â®|_"`%;:?'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -&\'./\\()#*^{}<>,@+$!Â®|_"`%;:?',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_name_office(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&\'./\\()#*^{}<>,@+$!Â®|_"`%;:?'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 80));
EXPORT InValidMessageFT_invalid_name_office(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -&\'./\\()#*^{}<>,@+$!Â®|_"`%;:?'),SALT31.HygieneErrors.NotLength('0..80'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_office_parse(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_office_parse(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['MD','GR',''],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_office_parse(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('MD|GR|'),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -_/.,@*(){}[]\',&#`";:\\'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -_/.,@*(){}[]\',&#`";:\\', ' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allupperandnums(s2);
END;
EXPORT InValidFT_invalid_name(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -_/.,@*(){}[]\',&#`";:\\'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789 -_/.,@*(){}[]\',&#`";:\\'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_gender(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['M','F','U',''],~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('M|F|U|'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prov_stat(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prov_stat(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['D','R',''],~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_prov_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('D|R|'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_credential(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_credential(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 14));
EXPORT InValidMessageFT_invalid_credential(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.NotLength('0..14'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_license_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_./#*`%()'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -_./#*`%()',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_license_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_./#*`%()'))));
EXPORT InValidMessageFT_invalid_license_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_./#*`%()'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_license_nbr(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prev_license_nbr(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_prev_license_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_license_type(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_prev_license_type(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_prev_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_license_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_license_state(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_license_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_raw_license_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.,()/#&'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -.,()/#&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_raw_license_type(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.,()/#&'))));
EXPORT InValidMessageFT_invalid_raw_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.,()/#&'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_license_type(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_license_type(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_invalid_std_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_license_desc(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_license_desc(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_invalid_std_license_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_raw_license_status(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyZ0123456789 -.()/#&'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -.()/#&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_raw_license_status(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxy0123456789 -.()/#&'))));
EXPORT InValidMessageFT_invalid_raw_license_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxy0123456789 -.()/#&'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_license_status(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_license_status(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_invalid_std_license_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_status_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.()/#&'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -.()/#&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_std_status_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.()/#&'))));
EXPORT InValidMessageFT_invalid_std_status_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.()/#&'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_renewal_dte(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NONE0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_renewal_dte(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NONE0123456789'))));
EXPORT InValidMessageFT_invalid_renewal_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('NONE0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_active_flag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_active_flag(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_active_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('01'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn_taxid_1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_ssn_taxid_1(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn_taxid_1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('0,9'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_tax_type_1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'E'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_tax_type_1(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'E'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_tax_type_1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('E'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn_taxid_2(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ssn_taxid_2(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn_taxid_2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_tax_type_2(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tax_type_2(SALT31.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_tax_type_2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_fed_rssd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_fed_rssd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 7));
EXPORT InValidMessageFT_invalid_fed_rssd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('0..7'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_bus_ind(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BWNRH '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_addr_bus_ind(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BWNRH '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_addr_bus_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('BWNRH '),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_format(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'FL'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_format(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'FL'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_name_format(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('FL'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_org_orig(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]-~\'`"()&.*#%{}|'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /\\@^Â¸:+$?_;,=![]-~\'`"()&.*#%{}|',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_name_org_orig(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]-~\'`"()&.*#%{}|'))));
EXPORT InValidMessageFT_invalid_name_org_orig(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]-~\'`"()&.*#%{}|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_dba_orig(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()<>&.*#{}%|'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /\\@Â¸:+$?_;,=![]-\'`"()<>&.*#{}%|',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_name_dba_orig(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()<>&.*#{}%|'))));
EXPORT InValidMessageFT_invalid_name_dba_orig(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"()<>&.*#{}%|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_mari_org(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]{}%-~\'`"()<>&.*#|'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /\\@^Â¸:+$?_;,=![]{}%-~\'`"()<>&.*#|',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_name_mari_org(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]{}%-~\'`"()<>&.*#|'))));
EXPORT InValidMessageFT_invalid_name_mari_org(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@^Â¸:+$?_;,=![]{}%-~\'`"()<>&.*#|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_mari_dba(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"(){}<>&.*#%'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /\\@Â¸:+$?_;,=![]-\'`"(){}<>&.*#%',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_allalphaandnums(s2);
END;
EXPORT InValidFT_invalid_name_mari_dba(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"(){}<>&.*#%'))));
EXPORT InValidMessageFT_invalid_name_mari_dba(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789 /\\@Â¸:+$?_;,=![]-\'`"(){}<>&.*#%'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_phone_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'Xx0123456789 ()-+./'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ()-+./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_phone_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'Xx0123456789 ()-+./'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_phone_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('Xx0123456789 ()-+./'),SALT31.HygieneErrors.NotLength('0,1..15'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_address(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-~.+%()\'\\:;"&#/`!@?*$><|_=*'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ,-~.+%()\'\\:;"&#/`!@?*$><|_=*',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_address(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-~.+%()\'\\:;"&#/`!@?*$><|_=*'))));
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,-~.+%()\'\\:;"&#/`!@?*$><|_=*'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,()\'\\,`"-&/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' .()\'\\,`"-&/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_city(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .()\'\\,`"-&/'))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .()\'\\,`"-&/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_state(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.NotLength('0,1,2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;                                                                                                                      
EXPORT InValidFT_invalid_zip5(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYabcdefghijklmnopqrstuvwxyzZ0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s))>0 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 '),SALT31.HygieneErrors.NotLength('0,1..5'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_zip4(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s))>0 AND LENGTH(TRIM(s)) <= 4));
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.NotLength('0,1..4'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_county(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-\'()&'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' .-\'()&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_county(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-\'()&'))));
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-\'()&'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_country(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ,.-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_country(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'))));
EXPORT InValidMessageFT_invalid_country(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_sud_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_sud_key(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_sud_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_ooc_ind(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ooc_ind(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'01'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_ooc_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('01'),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_addr_mail_ind(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'MH'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_mail_ind(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'MH'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_addr_mail_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('MH'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_license_nbr_contact(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'Y0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_license_nbr_contact(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'Y0123456789 '))));
EXPORT InValidMessageFT_invalid_license_nbr_contact(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('Y0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_email(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .@-\\_!,/&`+<>"#$\';'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' .@-\\_!,/&`+<>"#$\';',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_email(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .@-\\_!,/&`+<>"#$\';'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .@-\\_!,/&`+<>"#$\';'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_url(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /-@&\\:;.,'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /-@&\\:;.,',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_url(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /-@&\\:;.,'))));
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /-@&\\:;.,'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_bk_class(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABIMNOS '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_bk_class(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABIMNOS '))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_bk_class(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABIMNOS '),SALT31.HygieneErrors.NotLength('0..2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_bk_class_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ()-,.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_bk_class_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.'))));
EXPORT InValidMessageFT_invalid_bk_class_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_charter(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_charter(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_origin_cd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DELORSU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_origin_cd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DELORSU'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_origin_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('DELORSU'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_origin_cd_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,'/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_origin_cd_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ/'))));
EXPORT InValidMessageFT_invalid_origin_cd_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_disp_type_cd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'DPQRV'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_disp_type_cd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'DPQRV'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 1));
EXPORT InValidMessageFT_invalid_disp_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('DPQRV'),SALT31.HygieneErrors.NotLength('0..1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_disp_type_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_uppercase(s1);
END;
EXPORT InValidFT_invalid_disp_type_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_disp_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_reg_agent(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_reg_agent(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['FDIC','OCC','OTS','FED','']);
EXPORT InValidMessageFT_invalid_reg_agent(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('FDIC|OCC|OTS|FED|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_regulator(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces(SALT31.stringsubstituteout(s1,' ,.-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_regulator(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'))));
EXPORT InValidMessageFT_invalid_regulator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_hqtr_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.&\'/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ()-,.&\'/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_hqtr_name(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.&\'/'))));
EXPORT InValidMessageFT_invalid_hqtr_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()-,.&\'/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_domestic_off_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_domestic_off_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_domestic_off_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_foreign_off_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_foreign_off_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_foreign_off_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_hcr_rssd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_hcr_rssd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_hcr_rssd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_affil_type_cd(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_affil_type_cd(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['BO','BR','CO','IN','GR',''],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_affil_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('BO|BR|CO|IN|GR|'),SALT31.HygieneErrors.NotLength('0,2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_genlink(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'C0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_genlink(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'C0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_genlink(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('C0123456789'),SALT31.HygieneErrors.NotLength('0,10'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_research_ind(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_research_ind(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_research_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0'),SALT31.HygieneErrors.NotLength('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_docket_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_docket_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_docket_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_mltreckey(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_mltreckey(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_mltreckey(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cmc_slpk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_cmc_slpk(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_cmc_slpk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_pcmc_slpk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_pcmc_slpk(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_pcmc_slpk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_affil_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_affil_key(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_affil_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_provnote(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\|@Â¸:+$?_;,=![]-\'`"()&.*#{}'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' /\\|@Â¸:+$?_;,=![]-\'`"()&.*#{}',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_alphasandnums(s2);
END;
EXPORT InValidFT_invalid_provnote(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\|@Â¸:+$?_;,=![]-\'`"()&.*#{}'))));
EXPORT InValidMessageFT_invalid_provnote(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /\\|@Â¸:+$?_;,=![]-\'`"()&.*#{}'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_viol_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ,.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_viol_desc(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'))));
EXPORT InValidMessageFT_invalid_viol_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_displinary_action(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ,.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_displinary_action(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'))));
EXPORT InValidMessageFT_invalid_displinary_action(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_misc_other_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,'/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_nums(s2);
END;
EXPORT InValidFT_invalid_misc_other_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789/'))));
EXPORT InValidMessageFT_invalid_misc_other_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_misc_other_type(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_misc_other_type(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['MAS_FIL_NR','NEWCERT','POS. DOB/S','']);
EXPORT InValidMessageFT_invalid_misc_other_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('MAS_FIL_NR|NEWCERT|POS. DOB/S|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cont_education_ernd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' :/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_cont_education_ernd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'))));
EXPORT InValidMessageFT_invalid_cont_education_ernd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cont_education_req(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :|/.'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' :|/.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_cont_education_req(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :|/.'))));
EXPORT InValidMessageFT_invalid_cont_education_req(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :|/.'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cont_education_term(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' :/',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_cont_education_term(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'))));
EXPORT InValidMessageFT_invalid_cont_education_term(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :/'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_addl_license_spec(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ()-\'|'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ()-\'|',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_addl_license_spec(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ()-\'|'))));
EXPORT InValidMessageFT_invalid_addl_license_spec(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ()-\'|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_race_cd(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABHOPUW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_race_cd(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABHOPUW'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_race_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABHOPUW'),SALT31.HygieneErrors.NotLength('0..2'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_std_race_cd(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_std_race_cd(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['API','BLK','HISP','OTH','UNK','WHT','']);
EXPORT InValidMessageFT_invalid_std_race_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('API|BLK|HISP|OTH|UNK|WHT|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_agency_status(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agency_status(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['ACTIVE','INACTIVE','']);
EXPORT InValidMessageFT_invalid_agency_status(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('ACTIVE|INACTIVE|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_primary_key(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_prev_primary_key(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_prev_primary_key(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_mltreckey(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_prev_mltreckey(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_prev_mltreckey(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_cmc_slpk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_prev_cmc_slpk(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_prev_cmc_slpk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_prev_pcmc_slpk(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_prev_pcmc_slpk(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_prev_pcmc_slpk(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_license_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_license_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_license_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_nmls_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_nmls_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_nmls_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_foreign_nmls_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_nums(s1);
END;
EXPORT InValidFT_invalid_foreign_nmls_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_foreign_nmls_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_location_type(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_type(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['BRANCH','MAIN','WORK','']);
EXPORT InValidMessageFT_invalid_location_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('BRANCH|MAIN|WORK|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_off_license_nbr_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_off_license_nbr_type(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_off_license_nbr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_brkr_license_nbr(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -.',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_brkr_license_nbr(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.'))));
EXPORT InValidMessageFT_invalid_brkr_license_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -.'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_brkr_license_nbr_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 6/-'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' 6/-',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_brkr_license_nbr_type(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ 6/-'))));
EXPORT InValidMessageFT_invalid_brkr_license_nbr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ 6/-'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_agency_id(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercaseandnums(s2);
END;
EXPORT InValidFT_invalid_agency_id(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_agency_id(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_business_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -&'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -&',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_business_type(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -&'))));
EXPORT InValidMessageFT_invalid_business_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -&'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s0,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_type(SALT31.StrType s) := WHICH();
EXPORT InValidMessageFT_invalid_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_is_authorized(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_is_authorized(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['YES','NO','Yes','No','']);
EXPORT InValidMessageFT_invalid_is_authorized(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('YES|NO|Yes|No|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_federal_regulator(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_uppercase(s2);
END;
EXPORT InValidFT_invalid_federal_regulator(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))));
EXPORT InValidMessageFT_invalid_federal_regulator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'primary_key','create_dte','last_upd_dte','stamp_dte','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','process_date','gen_nbr','std_prof_cd','std_prof_desc','std_source_upd','std_source_desc','type_cd','name_org_prefx','name_org','name_org_sufx','store_nbr','name_dba_prefx','name_dba','name_dba_sufx','store_nbr_dba','dba_flag','name_office','office_parse','name_prefx','name_first','name_mid','name_last','name_sufx','name_nick','birth_dte','gender','prov_stat','credential','license_nbr','off_license_nbr','prev_license_nbr','prev_license_type','license_state','raw_license_type','std_license_type','std_license_desc','raw_license_status','std_license_status','std_status_desc','curr_issue_dte','orig_issue_dte','expire_dte','renewal_dte','active_flag','ssn_taxid_1','tax_type_1','ssn_taxid_2','tax_type_2','fed_rssd','addr_bus_ind','name_format','name_org_orig','name_dba_orig','name_mari_org','name_mari_dba','phn_mari_1','phn_mari_fax_1','phn_mari_2','phn_mari_fax_2','addr_addr1_1','addr_addr2_1','addr_addr3_1','addr_addr4_1','addr_city_1','addr_state_1','addr_zip5_1','addr_zip4_1','phn_phone_1','phn_fax_1','addr_cnty_1','addr_cntry_1','sud_key_1','ooc_ind_1','addr_mail_ind','addr_addr1_2','addr_addr2_2','addr_addr3_2','addr_addr4_2','addr_city_2','addr_state_2','addr_zip5_2','addr_zip4_2','addr_cnty_2','addr_cntry_2','phn_phone_2','phn_fax_2','sud_key_2','ooc_ind_2','license_nbr_contact','name_contact_prefx','name_contact_first','name_contact_mid','name_contact_last','name_contact_sufx','name_contact_nick','name_contact_ttl','phn_contact','phn_contact_ext','phn_contact_fax','email','url','bk_class','bk_class_desc','charter','inst_beg_dte','origin_cd','origin_cd_desc','disp_type_cd','disp_type_desc','reg_agent','regulator','hqtr_city','hqtr_name','domestic_off_nbr','foreign_off_nbr','hcr_rssd','hcr_location','affil_type_cd','genlink','research_ind','docket_id','mltreckey','cmc_slpk','pcmc_slpk','affil_key','provnote_1','provnote_2','provnote_3','action_taken_ind','viol_type','viol_cd','viol_desc','viol_dte','viol_case_nbr','viol_eff_dte','action_final_nbr','action_status','action_status_dte','displinary_action','action_file_name','occupation','practice_hrs','practice_type','misc_other_id','misc_other_type','cont_education_ernd','cont_education_req','cont_education_term','schl_attend_1','schl_attend_dte_1','schl_curriculum_1','schl_degree_1','schl_attend_2','schl_attend_dte_2','schl_curriculum_2','schl_degree_2','schl_attend_3','schl_attend_dte_3','schl_curriculum_3','schl_degree_3','addl_license_spec','place_birth_cd','place_birth_desc','race_cd','std_race_cd','race_desc','status_effect_dte','status_renew_desc','agency_status','prev_primary_key','prev_mltreckey','prev_cmc_slpk','prev_pcmc_slpk','license_id','nmls_id','foreign_nmls_id','location_type','off_license_nbr_type','brkr_license_nbr','brkr_license_nbr_type','agency_id','site_location','business_type','name_type','start_dte','is_authorized_license','is_authorized_conduct','federal_regulator');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'primary_key' => 1,'create_dte' => 2,'last_upd_dte' => 3,'stamp_dte' => 4,'date_first_seen' => 5,'date_last_seen' => 6,'date_vendor_first_reported' => 7,'date_vendor_last_reported' => 8,'process_date' => 9,'gen_nbr' => 10,'std_prof_cd' => 11,'std_prof_desc' => 12,'std_source_upd' => 13,'std_source_desc' => 14,'type_cd' => 15,'name_org_prefx' => 16,'name_org' => 17,'name_org_sufx' => 18,'store_nbr' => 19,'name_dba_prefx' => 20,'name_dba' => 21,'name_dba_sufx' => 22,'store_nbr_dba' => 23,'dba_flag' => 24,'name_office' => 25,'office_parse' => 26,'name_prefx' => 27,'name_first' => 28,'name_mid' => 29,'name_last' => 30,'name_sufx' => 31,'name_nick' => 32,'birth_dte' => 33,'gender' => 34,'prov_stat' => 35,'credential' => 36,'license_nbr' => 37,'off_license_nbr' => 38,'prev_license_nbr' => 39,'prev_license_type' => 40,'license_state' => 41,'raw_license_type' => 42,'std_license_type' => 43,'std_license_desc' => 44,'raw_license_status' => 45,'std_license_status' => 46,'std_status_desc' => 47,'curr_issue_dte' => 48,'orig_issue_dte' => 49,'expire_dte' => 50,'renewal_dte' => 51,'active_flag' => 52,'ssn_taxid_1' => 53,'tax_type_1' => 54,'ssn_taxid_2' => 55,'tax_type_2' => 56,'fed_rssd' => 57,'addr_bus_ind' => 58,'name_format' => 59,'name_org_orig' => 60,'name_dba_orig' => 61,'name_mari_org' => 62,'name_mari_dba' => 63,'phn_mari_1' => 64,'phn_mari_fax_1' => 65,'phn_mari_2' => 66,'phn_mari_fax_2' => 67,'addr_addr1_1' => 68,'addr_addr2_1' => 69,'addr_addr3_1' => 70,'addr_addr4_1' => 71,'addr_city_1' => 72,'addr_state_1' => 73,'addr_zip5_1' => 74,'addr_zip4_1' => 75,'phn_phone_1' => 76,'phn_fax_1' => 77,'addr_cnty_1' => 78,'addr_cntry_1' => 79,'sud_key_1' => 80,'ooc_ind_1' => 81,'addr_mail_ind' => 82,'addr_addr1_2' => 83,'addr_addr2_2' => 84,'addr_addr3_2' => 85,'addr_addr4_2' => 86,'addr_city_2' => 87,'addr_state_2' => 88,'addr_zip5_2' => 89,'addr_zip4_2' => 90,'addr_cnty_2' => 91,'addr_cntry_2' => 92,'phn_phone_2' => 93,'phn_fax_2' => 94,'sud_key_2' => 95,'ooc_ind_2' => 96,'license_nbr_contact' => 97,'name_contact_prefx' => 98,'name_contact_first' => 99,'name_contact_mid' => 100,'name_contact_last' => 101,'name_contact_sufx' => 102,'name_contact_nick' => 103,'name_contact_ttl' => 104,'phn_contact' => 105,'phn_contact_ext' => 106,'phn_contact_fax' => 107,'email' => 108,'url' => 109,'bk_class' => 110,'bk_class_desc' => 111,'charter' => 112,'inst_beg_dte' => 113,'origin_cd' => 114,'origin_cd_desc' => 115,'disp_type_cd' => 116,'disp_type_desc' => 117,'reg_agent' => 118,'regulator' => 119,'hqtr_city' => 120,'hqtr_name' => 121,'domestic_off_nbr' => 122,'foreign_off_nbr' => 123,'hcr_rssd' => 124,'hcr_location' => 125,'affil_type_cd' => 126,'genlink' => 127,'research_ind' => 128,'docket_id' => 129,'mltreckey' => 130,'cmc_slpk' => 131,'pcmc_slpk' => 132,'affil_key' => 133,'provnote_1' => 134,'provnote_2' => 135,'provnote_3' => 136,'action_taken_ind' => 137,'viol_type' => 138,'viol_cd' => 139,'viol_desc' => 140,'viol_dte' => 141,'viol_case_nbr' => 142,'viol_eff_dte' => 143,'action_final_nbr' => 144,'action_status' => 145,'action_status_dte' => 146,'displinary_action' => 147,'action_file_name' => 148,'occupation' => 149,'practice_hrs' => 150,'practice_type' => 151,'misc_other_id' => 152,'misc_other_type' => 153,'cont_education_ernd' => 154,'cont_education_req' => 155,'cont_education_term' => 156,'schl_attend_1' => 157,'schl_attend_dte_1' => 158,'schl_curriculum_1' => 159,'schl_degree_1' => 160,'schl_attend_2' => 161,'schl_attend_dte_2' => 162,'schl_curriculum_2' => 163,'schl_degree_2' => 164,'schl_attend_3' => 165,'schl_attend_dte_3' => 166,'schl_curriculum_3' => 167,'schl_degree_3' => 168,'addl_license_spec' => 169,'place_birth_cd' => 170,'place_birth_desc' => 171,'race_cd' => 172,'std_race_cd' => 173,'race_desc' => 174,'status_effect_dte' => 175,'status_renew_desc' => 176,'agency_status' => 177,'prev_primary_key' => 178,'prev_mltreckey' => 179,'prev_cmc_slpk' => 180,'prev_pcmc_slpk' => 181,'license_id' => 182,'nmls_id' => 183,'foreign_nmls_id' => 184,'location_type' => 185,'off_license_nbr_type' => 186,'brkr_license_nbr' => 187,'brkr_license_nbr_type' => 188,'agency_id' => 189,'site_location' => 190,'business_type' => 191,'name_type' => 192,'start_dte' => 193,'is_authorized_license' => 194,'is_authorized_conduct' => 195,'federal_regulator' => 196,0);
//Individual field level validation
EXPORT Make_primary_key(SALT31.StrType s0) := MakeFT_invalid_primary_key(s0);
EXPORT InValid_primary_key(SALT31.StrType s) := InValidFT_invalid_primary_key(s);
EXPORT InValidMessage_primary_key(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_key(wh);
EXPORT Make_create_dte(SALT31.StrType s0) := MakeFT_invalid_create_dte(s0);
EXPORT InValid_create_dte(SALT31.StrType s) := InValidFT_invalid_create_dte(s);
EXPORT InValidMessage_create_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_create_dte(wh);
EXPORT Make_last_upd_dte(SALT31.StrType s0) := MakeFT_invalid_last_upd_dte(s0);
EXPORT InValid_last_upd_dte(SALT31.StrType s) := InValidFT_invalid_last_upd_dte(s);
EXPORT InValidMessage_last_upd_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_last_upd_dte(wh);
EXPORT Make_stamp_dte(SALT31.StrType s0) := MakeFT_invalid_stamp_dte(s0);
EXPORT InValid_stamp_dte(SALT31.StrType s) := InValidFT_invalid_stamp_dte(s);
EXPORT InValidMessage_stamp_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_stamp_dte(wh);
EXPORT Make_date_first_seen(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_first_seen(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_last_seen(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_last_seen(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_first_reported(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_first_reported(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_date_vendor_last_reported(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_last_reported(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_process_date(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_gen_nbr(SALT31.StrType s0) := MakeFT_invalid_gen_nbr(s0);
EXPORT InValid_gen_nbr(SALT31.StrType s) := InValidFT_invalid_gen_nbr(s);
EXPORT InValidMessage_gen_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_gen_nbr(wh);
EXPORT Make_std_prof_cd(SALT31.StrType s0) := MakeFT_invalid_std_prof_cd(s0);
EXPORT InValid_std_prof_cd(SALT31.StrType s) := InValidFT_invalid_std_prof_cd(s);
EXPORT InValidMessage_std_prof_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_std_prof_cd(wh);
EXPORT Make_std_prof_desc(SALT31.StrType s0) := MakeFT_invalid_std_prof_desc(s0);
EXPORT InValid_std_prof_desc(SALT31.StrType s) := InValidFT_invalid_std_prof_desc(s);
EXPORT InValidMessage_std_prof_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_std_prof_desc(wh);
EXPORT Make_std_source_upd(SALT31.StrType s0) := MakeFT_invalid_std_source_upd(s0);
EXPORT InValid_std_source_upd(SALT31.StrType s) := InValidFT_invalid_std_source_upd(s);
EXPORT InValidMessage_std_source_upd(UNSIGNED1 wh) := InValidMessageFT_invalid_std_source_upd(wh);
EXPORT Make_std_source_desc(SALT31.StrType s0) := MakeFT_invalid_std_source_desc(s0);
EXPORT InValid_std_source_desc(SALT31.StrType s) := InValidFT_invalid_std_source_desc(s);
EXPORT InValidMessage_std_source_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_std_source_desc(wh);
EXPORT Make_type_cd(SALT31.StrType s0) := MakeFT_invalid_type_cd(s0);
EXPORT InValid_type_cd(SALT31.StrType s) := InValidFT_invalid_type_cd(s);
EXPORT InValidMessage_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_type_cd(wh);
EXPORT Make_name_org_prefx(SALT31.StrType s0) := MakeFT_invalid_name_org_prefx(s0);
EXPORT InValid_name_org_prefx(SALT31.StrType s) := InValidFT_invalid_name_org_prefx(s);
EXPORT InValidMessage_name_org_prefx(UNSIGNED1 wh) := InValidMessageFT_invalid_name_org_prefx(wh);
EXPORT Make_name_org(SALT31.StrType s0) := MakeFT_invalid_name_org(s0);
EXPORT InValid_name_org(SALT31.StrType s) := InValidFT_invalid_name_org(s);
EXPORT InValidMessage_name_org(UNSIGNED1 wh) := InValidMessageFT_invalid_name_org(wh);
EXPORT Make_name_org_sufx(SALT31.StrType s0) := MakeFT_invalid_name_org_sufx(s0);
EXPORT InValid_name_org_sufx(SALT31.StrType s) := InValidFT_invalid_name_org_sufx(s);
EXPORT InValidMessage_name_org_sufx(UNSIGNED1 wh) := InValidMessageFT_invalid_name_org_sufx(wh);
EXPORT Make_store_nbr(SALT31.StrType s0) := MakeFT_invalid_store_nbr(s0);
EXPORT InValid_store_nbr(SALT31.StrType s) := InValidFT_invalid_store_nbr(s);
EXPORT InValidMessage_store_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_store_nbr(wh);
EXPORT Make_name_dba_prefx(SALT31.StrType s0) := MakeFT_invalid_name_dba_prefx(s0);
EXPORT InValid_name_dba_prefx(SALT31.StrType s) := InValidFT_invalid_name_dba_prefx(s);
EXPORT InValidMessage_name_dba_prefx(UNSIGNED1 wh) := InValidMessageFT_invalid_name_dba_prefx(wh);
EXPORT Make_name_dba(SALT31.StrType s0) := MakeFT_invalid_name_dba(s0);
EXPORT InValid_name_dba(SALT31.StrType s) := InValidFT_invalid_name_dba(s);
EXPORT InValidMessage_name_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_name_dba(wh);
EXPORT Make_name_dba_sufx(SALT31.StrType s0) := MakeFT_invalid_name_dba_sufx(s0);
EXPORT InValid_name_dba_sufx(SALT31.StrType s) := InValidFT_invalid_name_dba_sufx(s);
EXPORT InValidMessage_name_dba_sufx(UNSIGNED1 wh) := InValidMessageFT_invalid_name_dba_sufx(wh);
EXPORT Make_store_nbr_dba(SALT31.StrType s0) := MakeFT_invalid_store_nbr_dba(s0);
EXPORT InValid_store_nbr_dba(SALT31.StrType s) := InValidFT_invalid_store_nbr_dba(s);
EXPORT InValidMessage_store_nbr_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_store_nbr_dba(wh);
EXPORT Make_dba_flag(SALT31.StrType s0) := MakeFT_invalid_dba_flag(s0);
EXPORT InValid_dba_flag(SALT31.StrType s) := InValidFT_invalid_dba_flag(s);
EXPORT InValidMessage_dba_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_dba_flag(wh);
EXPORT Make_name_office(SALT31.StrType s0) := MakeFT_invalid_name_office(s0);
EXPORT InValid_name_office(SALT31.StrType s) := InValidFT_invalid_name_office(s);
EXPORT InValidMessage_name_office(UNSIGNED1 wh) := InValidMessageFT_invalid_name_office(wh);
EXPORT Make_office_parse(SALT31.StrType s0) := MakeFT_invalid_office_parse(s0);
EXPORT InValid_office_parse(SALT31.StrType s) := InValidFT_invalid_office_parse(s);
EXPORT InValidMessage_office_parse(UNSIGNED1 wh) := InValidMessageFT_invalid_office_parse(wh);
EXPORT Make_name_prefx(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_prefx(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_prefx(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_first(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_first(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_first(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_mid(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_mid(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_mid(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_last(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_last(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_sufx(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_sufx(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_sufx(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_nick(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_nick(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_nick(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_birth_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_birth_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_birth_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_gender(SALT31.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT31.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
EXPORT Make_prov_stat(SALT31.StrType s0) := MakeFT_invalid_prov_stat(s0);
EXPORT InValid_prov_stat(SALT31.StrType s) := InValidFT_invalid_prov_stat(s);
EXPORT InValidMessage_prov_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_prov_stat(wh);
EXPORT Make_credential(SALT31.StrType s0) := MakeFT_invalid_credential(s0);
EXPORT InValid_credential(SALT31.StrType s) := InValidFT_invalid_credential(s);
EXPORT InValidMessage_credential(UNSIGNED1 wh) := InValidMessageFT_invalid_credential(wh);
EXPORT Make_license_nbr(SALT31.StrType s0) := MakeFT_invalid_license_nbr(s0);
EXPORT InValid_license_nbr(SALT31.StrType s) := InValidFT_invalid_license_nbr(s);
EXPORT InValidMessage_license_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_license_nbr(wh);
EXPORT Make_off_license_nbr(SALT31.StrType s0) := MakeFT_invalid_license_nbr(s0);
EXPORT InValid_off_license_nbr(SALT31.StrType s) := InValidFT_invalid_license_nbr(s);
EXPORT InValidMessage_off_license_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_license_nbr(wh);
EXPORT Make_prev_license_nbr(SALT31.StrType s0) := MakeFT_invalid_prev_license_nbr(s0);
EXPORT InValid_prev_license_nbr(SALT31.StrType s) := InValidFT_invalid_prev_license_nbr(s);
EXPORT InValidMessage_prev_license_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_license_nbr(wh);
EXPORT Make_prev_license_type(SALT31.StrType s0) := MakeFT_invalid_prev_license_type(s0);
EXPORT InValid_prev_license_type(SALT31.StrType s) := InValidFT_invalid_prev_license_type(s);
EXPORT InValidMessage_prev_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_license_type(wh);
EXPORT Make_license_state(SALT31.StrType s0) := MakeFT_invalid_license_state(s0);
EXPORT InValid_license_state(SALT31.StrType s) := InValidFT_invalid_license_state(s);
EXPORT InValidMessage_license_state(UNSIGNED1 wh) := InValidMessageFT_invalid_license_state(wh);
EXPORT Make_raw_license_type(SALT31.StrType s0) := MakeFT_invalid_raw_license_type(s0);
EXPORT InValid_raw_license_type(SALT31.StrType s) := InValidFT_invalid_raw_license_type(s);
EXPORT InValidMessage_raw_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_license_type(wh);
EXPORT Make_std_license_type(SALT31.StrType s0) := MakeFT_invalid_std_license_type(s0);
EXPORT InValid_std_license_type(SALT31.StrType s) := InValidFT_invalid_std_license_type(s);
EXPORT InValidMessage_std_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_std_license_type(wh);
EXPORT Make_std_license_desc(SALT31.StrType s0) := MakeFT_invalid_std_license_desc(s0);
EXPORT InValid_std_license_desc(SALT31.StrType s) := InValidFT_invalid_std_license_desc(s);
EXPORT InValidMessage_std_license_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_std_license_desc(wh);
EXPORT Make_raw_license_status(SALT31.StrType s0) := MakeFT_invalid_raw_license_status(s0);
EXPORT InValid_raw_license_status(SALT31.StrType s) := InValidFT_invalid_raw_license_status(s);
EXPORT InValidMessage_raw_license_status(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_license_status(wh);
EXPORT Make_std_license_status(SALT31.StrType s0) := MakeFT_invalid_std_license_status(s0);
EXPORT InValid_std_license_status(SALT31.StrType s) := InValidFT_invalid_std_license_status(s);
EXPORT InValidMessage_std_license_status(UNSIGNED1 wh) := InValidMessageFT_invalid_std_license_status(wh);
EXPORT Make_std_status_desc(SALT31.StrType s0) := MakeFT_invalid_std_status_desc(s0);
EXPORT InValid_std_status_desc(SALT31.StrType s) := InValidFT_invalid_std_status_desc(s);
EXPORT InValidMessage_std_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_std_status_desc(wh);
EXPORT Make_curr_issue_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_curr_issue_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_curr_issue_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_issue_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_issue_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_issue_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_expire_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_expire_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_expire_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_renewal_dte(SALT31.StrType s0) := MakeFT_invalid_renewal_dte(s0);
EXPORT InValid_renewal_dte(SALT31.StrType s) := InValidFT_invalid_renewal_dte(s);
EXPORT InValidMessage_renewal_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_renewal_dte(wh);
EXPORT Make_active_flag(SALT31.StrType s0) := MakeFT_invalid_active_flag(s0);
EXPORT InValid_active_flag(SALT31.StrType s) := InValidFT_invalid_active_flag(s);
EXPORT InValidMessage_active_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_active_flag(wh);
EXPORT Make_ssn_taxid_1(SALT31.StrType s0) := MakeFT_invalid_ssn_taxid_1(s0);
EXPORT InValid_ssn_taxid_1(SALT31.StrType s) := InValidFT_invalid_ssn_taxid_1(s);
EXPORT InValidMessage_ssn_taxid_1(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn_taxid_1(wh);
EXPORT Make_tax_type_1(SALT31.StrType s0) := MakeFT_invalid_tax_type_1(s0);
EXPORT InValid_tax_type_1(SALT31.StrType s) := InValidFT_invalid_tax_type_1(s);
EXPORT InValidMessage_tax_type_1(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_type_1(wh);
EXPORT Make_ssn_taxid_2(SALT31.StrType s0) := MakeFT_invalid_ssn_taxid_2(s0);
EXPORT InValid_ssn_taxid_2(SALT31.StrType s) := InValidFT_invalid_ssn_taxid_2(s);
EXPORT InValidMessage_ssn_taxid_2(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn_taxid_2(wh);
EXPORT Make_tax_type_2(SALT31.StrType s0) := MakeFT_invalid_tax_type_2(s0);
EXPORT InValid_tax_type_2(SALT31.StrType s) := InValidFT_invalid_tax_type_2(s);
EXPORT InValidMessage_tax_type_2(UNSIGNED1 wh) := InValidMessageFT_invalid_tax_type_2(wh);
EXPORT Make_fed_rssd(SALT31.StrType s0) := MakeFT_invalid_fed_rssd(s0);
EXPORT InValid_fed_rssd(SALT31.StrType s) := InValidFT_invalid_fed_rssd(s);
EXPORT InValidMessage_fed_rssd(UNSIGNED1 wh) := InValidMessageFT_invalid_fed_rssd(wh);
EXPORT Make_addr_bus_ind(SALT31.StrType s0) := MakeFT_invalid_addr_bus_ind(s0);
EXPORT InValid_addr_bus_ind(SALT31.StrType s) := InValidFT_invalid_addr_bus_ind(s);
EXPORT InValidMessage_addr_bus_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_bus_ind(wh);
EXPORT Make_name_format(SALT31.StrType s0) := MakeFT_invalid_name_format(s0);
EXPORT InValid_name_format(SALT31.StrType s) := InValidFT_invalid_name_format(s);
EXPORT InValidMessage_name_format(UNSIGNED1 wh) := InValidMessageFT_invalid_name_format(wh);
EXPORT Make_name_org_orig(SALT31.StrType s0) := MakeFT_invalid_name_org_orig(s0);
EXPORT InValid_name_org_orig(SALT31.StrType s) := InValidFT_invalid_name_org_orig(s);
EXPORT InValidMessage_name_org_orig(UNSIGNED1 wh) := InValidMessageFT_invalid_name_org_orig(wh);
EXPORT Make_name_dba_orig(SALT31.StrType s0) := MakeFT_invalid_name_dba_orig(s0);
EXPORT InValid_name_dba_orig(SALT31.StrType s) := InValidFT_invalid_name_dba_orig(s);
EXPORT InValidMessage_name_dba_orig(UNSIGNED1 wh) := InValidMessageFT_invalid_name_dba_orig(wh);
EXPORT Make_name_mari_org(SALT31.StrType s0) := MakeFT_invalid_name_mari_org(s0);
EXPORT InValid_name_mari_org(SALT31.StrType s) := InValidFT_invalid_name_mari_org(s);
EXPORT InValidMessage_name_mari_org(UNSIGNED1 wh) := InValidMessageFT_invalid_name_mari_org(wh);
EXPORT Make_name_mari_dba(SALT31.StrType s0) := MakeFT_invalid_name_mari_dba(s0);
EXPORT InValid_name_mari_dba(SALT31.StrType s) := InValidFT_invalid_name_mari_dba(s);
EXPORT InValidMessage_name_mari_dba(UNSIGNED1 wh) := InValidMessageFT_invalid_name_mari_dba(wh);
EXPORT Make_phn_mari_1(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_mari_1(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_mari_1(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_mari_fax_1(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_mari_fax_1(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_mari_fax_1(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_mari_2(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_mari_2(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_mari_2(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_mari_fax_2(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_mari_fax_2(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_mari_fax_2(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_addr_addr1_1(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr1_1(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr1_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr2_1(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr2_1(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr2_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr3_1(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr3_1(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr3_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr4_1(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr4_1(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr4_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_city_1(SALT31.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_addr_city_1(SALT31.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_addr_city_1(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_addr_state_1(SALT31.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_addr_state_1(SALT31.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_addr_state_1(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_addr_zip5_1(SALT31.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_addr_zip5_1(SALT31.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_addr_zip5_1(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
EXPORT Make_addr_zip4_1(SALT31.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_addr_zip4_1(SALT31.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_addr_zip4_1(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_phn_phone_1(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_phone_1(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_phone_1(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_fax_1(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_fax_1(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_fax_1(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_addr_cnty_1(SALT31.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_addr_cnty_1(SALT31.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_addr_cnty_1(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
EXPORT Make_addr_cntry_1(SALT31.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_addr_cntry_1(SALT31.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_addr_cntry_1(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
EXPORT Make_sud_key_1(SALT31.StrType s0) := MakeFT_invalid_sud_key(s0);
EXPORT InValid_sud_key_1(SALT31.StrType s) := InValidFT_invalid_sud_key(s);
EXPORT InValidMessage_sud_key_1(UNSIGNED1 wh) := InValidMessageFT_invalid_sud_key(wh);
EXPORT Make_ooc_ind_1(SALT31.StrType s0) := MakeFT_invalid_ooc_ind(s0);
EXPORT InValid_ooc_ind_1(SALT31.StrType s) := InValidFT_invalid_ooc_ind(s);
EXPORT InValidMessage_ooc_ind_1(UNSIGNED1 wh) := InValidMessageFT_invalid_ooc_ind(wh);
EXPORT Make_addr_mail_ind(SALT31.StrType s0) := MakeFT_invalid_addr_mail_ind(s0);
EXPORT InValid_addr_mail_ind(SALT31.StrType s) := InValidFT_invalid_addr_mail_ind(s);
EXPORT InValidMessage_addr_mail_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_mail_ind(wh);
EXPORT Make_addr_addr1_2(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr1_2(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr1_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr2_2(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr2_2(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr2_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr3_2(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr3_2(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr3_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_addr4_2(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_addr_addr4_2(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_addr_addr4_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_addr_city_2(SALT31.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_addr_city_2(SALT31.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_addr_city_2(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_addr_state_2(SALT31.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_addr_state_2(SALT31.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_addr_state_2(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_addr_zip5_2(SALT31.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_addr_zip5_2(SALT31.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_addr_zip5_2(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
EXPORT Make_addr_zip4_2(SALT31.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_addr_zip4_2(SALT31.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_addr_zip4_2(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
EXPORT Make_addr_cnty_2(SALT31.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_addr_cnty_2(SALT31.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_addr_cnty_2(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
EXPORT Make_addr_cntry_2(SALT31.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_addr_cntry_2(SALT31.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_addr_cntry_2(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
EXPORT Make_phn_phone_2(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_phone_2(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_phone_2(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_fax_2(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_fax_2(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_fax_2(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_sud_key_2(SALT31.StrType s0) := MakeFT_invalid_sud_key(s0);
EXPORT InValid_sud_key_2(SALT31.StrType s) := InValidFT_invalid_sud_key(s);
EXPORT InValidMessage_sud_key_2(UNSIGNED1 wh) := InValidMessageFT_invalid_sud_key(wh);
EXPORT Make_ooc_ind_2(SALT31.StrType s0) := MakeFT_invalid_ooc_ind(s0);
EXPORT InValid_ooc_ind_2(SALT31.StrType s) := InValidFT_invalid_ooc_ind(s);
EXPORT InValidMessage_ooc_ind_2(UNSIGNED1 wh) := InValidMessageFT_invalid_ooc_ind(wh);
EXPORT Make_license_nbr_contact(SALT31.StrType s0) := MakeFT_invalid_license_nbr_contact(s0);
EXPORT InValid_license_nbr_contact(SALT31.StrType s) := InValidFT_invalid_license_nbr_contact(s);
EXPORT InValidMessage_license_nbr_contact(UNSIGNED1 wh) := InValidMessageFT_invalid_license_nbr_contact(wh);
EXPORT Make_name_contact_prefx(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_prefx(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_prefx(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_first(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_first(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_first(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_mid(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_mid(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_mid(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_last(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_last(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_last(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_sufx(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_sufx(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_sufx(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_nick(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_nick(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_nick(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_contact_ttl(SALT31.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_contact_ttl(SALT31.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_contact_ttl(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_phn_contact(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_contact(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_contact(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_contact_ext(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_contact_ext(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_contact_ext(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_phn_contact_fax(SALT31.StrType s0) := MakeFT_invalid_phone_number(s0);
EXPORT InValid_phn_contact_fax(SALT31.StrType s) := InValidFT_invalid_phone_number(s);
EXPORT InValidMessage_phn_contact_fax(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_number(wh);
EXPORT Make_email(SALT31.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT31.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
EXPORT Make_url(SALT31.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT31.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
EXPORT Make_bk_class(SALT31.StrType s0) := MakeFT_invalid_bk_class(s0);
EXPORT InValid_bk_class(SALT31.StrType s) := InValidFT_invalid_bk_class(s);
EXPORT InValidMessage_bk_class(UNSIGNED1 wh) := InValidMessageFT_invalid_bk_class(wh);
EXPORT Make_bk_class_desc(SALT31.StrType s0) := MakeFT_invalid_bk_class_desc(s0);
EXPORT InValid_bk_class_desc(SALT31.StrType s) := InValidFT_invalid_bk_class_desc(s);
EXPORT InValidMessage_bk_class_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_bk_class_desc(wh);
EXPORT Make_charter(SALT31.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_charter(SALT31.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_charter(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
EXPORT Make_inst_beg_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_inst_beg_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_inst_beg_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_origin_cd(SALT31.StrType s0) := MakeFT_invalid_origin_cd(s0);
EXPORT InValid_origin_cd(SALT31.StrType s) := InValidFT_invalid_origin_cd(s);
EXPORT InValidMessage_origin_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_origin_cd(wh);
EXPORT Make_origin_cd_desc(SALT31.StrType s0) := MakeFT_invalid_origin_cd_desc(s0);
EXPORT InValid_origin_cd_desc(SALT31.StrType s) := InValidFT_invalid_origin_cd_desc(s);
EXPORT InValidMessage_origin_cd_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_origin_cd_desc(wh);
EXPORT Make_disp_type_cd(SALT31.StrType s0) := MakeFT_invalid_disp_type_cd(s0);
EXPORT InValid_disp_type_cd(SALT31.StrType s) := InValidFT_invalid_disp_type_cd(s);
EXPORT InValidMessage_disp_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_disp_type_cd(wh);
EXPORT Make_disp_type_desc(SALT31.StrType s0) := MakeFT_invalid_disp_type_desc(s0);
EXPORT InValid_disp_type_desc(SALT31.StrType s) := InValidFT_invalid_disp_type_desc(s);
EXPORT InValidMessage_disp_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_disp_type_desc(wh);
EXPORT Make_reg_agent(SALT31.StrType s0) := MakeFT_invalid_reg_agent(s0);
EXPORT InValid_reg_agent(SALT31.StrType s) := InValidFT_invalid_reg_agent(s);
EXPORT InValidMessage_reg_agent(UNSIGNED1 wh) := InValidMessageFT_invalid_reg_agent(wh);
EXPORT Make_regulator(SALT31.StrType s0) := MakeFT_invalid_regulator(s0);
EXPORT InValid_regulator(SALT31.StrType s) := InValidFT_invalid_regulator(s);
EXPORT InValidMessage_regulator(UNSIGNED1 wh) := InValidMessageFT_invalid_regulator(wh);
EXPORT Make_hqtr_city(SALT31.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_hqtr_city(SALT31.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_hqtr_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
EXPORT Make_hqtr_name(SALT31.StrType s0) := MakeFT_invalid_hqtr_name(s0);
EXPORT InValid_hqtr_name(SALT31.StrType s) := InValidFT_invalid_hqtr_name(s);
EXPORT InValidMessage_hqtr_name(UNSIGNED1 wh) := InValidMessageFT_invalid_hqtr_name(wh);
EXPORT Make_domestic_off_nbr(SALT31.StrType s0) := MakeFT_invalid_domestic_off_nbr(s0);
EXPORT InValid_domestic_off_nbr(SALT31.StrType s) := InValidFT_invalid_domestic_off_nbr(s);
EXPORT InValidMessage_domestic_off_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_domestic_off_nbr(wh);
EXPORT Make_foreign_off_nbr(SALT31.StrType s0) := MakeFT_invalid_foreign_off_nbr(s0);
EXPORT InValid_foreign_off_nbr(SALT31.StrType s) := InValidFT_invalid_foreign_off_nbr(s);
EXPORT InValidMessage_foreign_off_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_foreign_off_nbr(wh);
EXPORT Make_hcr_rssd(SALT31.StrType s0) := MakeFT_invalid_hcr_rssd(s0);
EXPORT InValid_hcr_rssd(SALT31.StrType s) := InValidFT_invalid_hcr_rssd(s);
EXPORT InValidMessage_hcr_rssd(UNSIGNED1 wh) := InValidMessageFT_invalid_hcr_rssd(wh);
EXPORT Make_hcr_location(SALT31.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_hcr_location(SALT31.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_hcr_location(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_affil_type_cd(SALT31.StrType s0) := MakeFT_invalid_affil_type_cd(s0);
EXPORT InValid_affil_type_cd(SALT31.StrType s) := InValidFT_invalid_affil_type_cd(s);
EXPORT InValidMessage_affil_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_affil_type_cd(wh);
EXPORT Make_genlink(SALT31.StrType s0) := MakeFT_invalid_genlink(s0);
EXPORT InValid_genlink(SALT31.StrType s) := InValidFT_invalid_genlink(s);
EXPORT InValidMessage_genlink(UNSIGNED1 wh) := InValidMessageFT_invalid_genlink(wh);
EXPORT Make_research_ind(SALT31.StrType s0) := MakeFT_invalid_research_ind(s0);
EXPORT InValid_research_ind(SALT31.StrType s) := InValidFT_invalid_research_ind(s);
EXPORT InValidMessage_research_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_research_ind(wh);
EXPORT Make_docket_id(SALT31.StrType s0) := MakeFT_invalid_docket_id(s0);
EXPORT InValid_docket_id(SALT31.StrType s) := InValidFT_invalid_docket_id(s);
EXPORT InValidMessage_docket_id(UNSIGNED1 wh) := InValidMessageFT_invalid_docket_id(wh);
EXPORT Make_mltreckey(SALT31.StrType s0) := MakeFT_invalid_mltreckey(s0);
EXPORT InValid_mltreckey(SALT31.StrType s) := InValidFT_invalid_mltreckey(s);
EXPORT InValidMessage_mltreckey(UNSIGNED1 wh) := InValidMessageFT_invalid_mltreckey(wh);
EXPORT Make_cmc_slpk(SALT31.StrType s0) := MakeFT_invalid_cmc_slpk(s0);
EXPORT InValid_cmc_slpk(SALT31.StrType s) := InValidFT_invalid_cmc_slpk(s);
EXPORT InValidMessage_cmc_slpk(UNSIGNED1 wh) := InValidMessageFT_invalid_cmc_slpk(wh);
EXPORT Make_pcmc_slpk(SALT31.StrType s0) := MakeFT_invalid_pcmc_slpk(s0);
EXPORT InValid_pcmc_slpk(SALT31.StrType s) := InValidFT_invalid_pcmc_slpk(s);
EXPORT InValidMessage_pcmc_slpk(UNSIGNED1 wh) := InValidMessageFT_invalid_pcmc_slpk(wh);
EXPORT Make_affil_key(SALT31.StrType s0) := MakeFT_invalid_affil_key(s0);
EXPORT InValid_affil_key(SALT31.StrType s) := InValidFT_invalid_affil_key(s);
EXPORT InValidMessage_affil_key(UNSIGNED1 wh) := InValidMessageFT_invalid_affil_key(wh);
EXPORT Make_provnote_1(SALT31.StrType s0) := s0;
EXPORT InValid_provnote_1(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_provnote_1(UNSIGNED1 wh) := '';
EXPORT Make_provnote_2(SALT31.StrType s0) := s0;
EXPORT InValid_provnote_2(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_provnote_2(UNSIGNED1 wh) := '';
EXPORT Make_provnote_3(SALT31.StrType s0) := s0;
EXPORT InValid_provnote_3(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_provnote_3(UNSIGNED1 wh) := '';
EXPORT Make_action_taken_ind(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_action_taken_ind(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_action_taken_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_viol_type(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_viol_type(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_viol_type(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_viol_cd(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_viol_cd(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_viol_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_viol_desc(SALT31.StrType s0) := MakeFT_invalid_viol_desc(s0);
EXPORT InValid_viol_desc(SALT31.StrType s) := InValidFT_invalid_viol_desc(s);
EXPORT InValidMessage_viol_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_viol_desc(wh);
EXPORT Make_viol_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_viol_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_viol_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_viol_case_nbr(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_viol_case_nbr(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_viol_case_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_viol_eff_dte(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_viol_eff_dte(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_viol_eff_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_action_final_nbr(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_action_final_nbr(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_action_final_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_action_status(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_action_status(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_action_status(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_action_status_dte(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_action_status_dte(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_action_status_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_displinary_action(SALT31.StrType s0) := s0;
EXPORT InValid_displinary_action(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_displinary_action(UNSIGNED1 wh) := '';
EXPORT Make_action_file_name(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_action_file_name(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_action_file_name(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_occupation(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_occupation(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_occupation(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_practice_hrs(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_practice_hrs(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_practice_hrs(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_practice_type(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_practice_type(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_practice_type(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_misc_other_id(SALT31.StrType s0) := MakeFT_invalid_misc_other_id(s0);
EXPORT InValid_misc_other_id(SALT31.StrType s) := InValidFT_invalid_misc_other_id(s);
EXPORT InValidMessage_misc_other_id(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_other_id(wh);
EXPORT Make_misc_other_type(SALT31.StrType s0) := MakeFT_invalid_misc_other_type(s0);
EXPORT InValid_misc_other_type(SALT31.StrType s) := InValidFT_invalid_misc_other_type(s);
EXPORT InValidMessage_misc_other_type(UNSIGNED1 wh) := InValidMessageFT_invalid_misc_other_type(wh);
EXPORT Make_cont_education_ernd(SALT31.StrType s0) := MakeFT_invalid_cont_education_ernd(s0);
EXPORT InValid_cont_education_ernd(SALT31.StrType s) := InValidFT_invalid_cont_education_ernd(s);
EXPORT InValidMessage_cont_education_ernd(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_education_ernd(wh);
EXPORT Make_cont_education_req(SALT31.StrType s0) := MakeFT_invalid_cont_education_req(s0);
EXPORT InValid_cont_education_req(SALT31.StrType s) := InValidFT_invalid_cont_education_req(s);
EXPORT InValidMessage_cont_education_req(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_education_req(wh);
EXPORT Make_cont_education_term(SALT31.StrType s0) := MakeFT_invalid_cont_education_term(s0);
EXPORT InValid_cont_education_term(SALT31.StrType s) := InValidFT_invalid_cont_education_term(s);
EXPORT InValidMessage_cont_education_term(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_education_term(wh);
EXPORT Make_schl_attend_1(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_1(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_1(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_attend_dte_1(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_dte_1(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_dte_1(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_curriculum_1(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_curriculum_1(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_curriculum_1(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_degree_1(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_degree_1(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_degree_1(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_attend_2(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_2(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_2(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_attend_dte_2(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_dte_2(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_dte_2(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_curriculum_2(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_curriculum_2(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_curriculum_2(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_degree_2(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_degree_2(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_degree_2(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_attend_3(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_3(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_3(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_attend_dte_3(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_attend_dte_3(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_attend_dte_3(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_curriculum_3(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_curriculum_3(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_curriculum_3(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_schl_degree_3(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_schl_degree_3(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_schl_degree_3(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_addl_license_spec(SALT31.StrType s0) := MakeFT_invalid_addl_license_spec(s0);
EXPORT InValid_addl_license_spec(SALT31.StrType s) := InValidFT_invalid_addl_license_spec(s);
EXPORT InValidMessage_addl_license_spec(UNSIGNED1 wh) := InValidMessageFT_invalid_addl_license_spec(wh);
EXPORT Make_place_birth_cd(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_place_birth_cd(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_place_birth_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_place_birth_desc(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_place_birth_desc(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_place_birth_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_race_cd(SALT31.StrType s0) := MakeFT_invalid_race_cd(s0);
EXPORT InValid_race_cd(SALT31.StrType s) := InValidFT_invalid_race_cd(s);
EXPORT InValidMessage_race_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_race_cd(wh);
EXPORT Make_std_race_cd(SALT31.StrType s0) := MakeFT_invalid_std_race_cd(s0);
EXPORT InValid_std_race_cd(SALT31.StrType s) := InValidFT_invalid_std_race_cd(s);
EXPORT InValidMessage_std_race_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_std_race_cd(wh);
EXPORT Make_race_desc(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_race_desc(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_race_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_status_effect_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_status_effect_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_status_effect_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_status_renew_desc(SALT31.StrType s0) := MakeFT_invalid_blank(s0);
EXPORT InValid_status_renew_desc(SALT31.StrType s) := InValidFT_invalid_blank(s);
EXPORT InValidMessage_status_renew_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_blank(wh);
EXPORT Make_agency_status(SALT31.StrType s0) := MakeFT_invalid_agency_status(s0);
EXPORT InValid_agency_status(SALT31.StrType s) := InValidFT_invalid_agency_status(s);
EXPORT InValidMessage_agency_status(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_status(wh);
EXPORT Make_prev_primary_key(SALT31.StrType s0) := MakeFT_invalid_prev_primary_key(s0);
EXPORT InValid_prev_primary_key(SALT31.StrType s) := InValidFT_invalid_prev_primary_key(s);
EXPORT InValidMessage_prev_primary_key(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_primary_key(wh);
EXPORT Make_prev_mltreckey(SALT31.StrType s0) := MakeFT_invalid_prev_mltreckey(s0);
EXPORT InValid_prev_mltreckey(SALT31.StrType s) := InValidFT_invalid_prev_mltreckey(s);
EXPORT InValidMessage_prev_mltreckey(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_mltreckey(wh);
EXPORT Make_prev_cmc_slpk(SALT31.StrType s0) := MakeFT_invalid_prev_cmc_slpk(s0);
EXPORT InValid_prev_cmc_slpk(SALT31.StrType s) := InValidFT_invalid_prev_cmc_slpk(s);
EXPORT InValidMessage_prev_cmc_slpk(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_cmc_slpk(wh);
EXPORT Make_prev_pcmc_slpk(SALT31.StrType s0) := MakeFT_invalid_prev_pcmc_slpk(s0);
EXPORT InValid_prev_pcmc_slpk(SALT31.StrType s) := InValidFT_invalid_prev_pcmc_slpk(s);
EXPORT InValidMessage_prev_pcmc_slpk(UNSIGNED1 wh) := InValidMessageFT_invalid_prev_pcmc_slpk(wh);
EXPORT Make_license_id(SALT31.StrType s0) := MakeFT_invalid_license_id(s0);
EXPORT InValid_license_id(SALT31.StrType s) := InValidFT_invalid_license_id(s);
EXPORT InValidMessage_license_id(UNSIGNED1 wh) := InValidMessageFT_invalid_license_id(wh);
EXPORT Make_nmls_id(SALT31.StrType s0) := MakeFT_invalid_nmls_id(s0);
EXPORT InValid_nmls_id(SALT31.StrType s) := InValidFT_invalid_nmls_id(s);
EXPORT InValidMessage_nmls_id(UNSIGNED1 wh) := InValidMessageFT_invalid_nmls_id(wh);
EXPORT Make_foreign_nmls_id(SALT31.StrType s0) := MakeFT_invalid_foreign_nmls_id(s0);
EXPORT InValid_foreign_nmls_id(SALT31.StrType s) := InValidFT_invalid_foreign_nmls_id(s);
EXPORT InValidMessage_foreign_nmls_id(UNSIGNED1 wh) := InValidMessageFT_invalid_foreign_nmls_id(wh);
EXPORT Make_location_type(SALT31.StrType s0) := MakeFT_invalid_location_type(s0);
EXPORT InValid_location_type(SALT31.StrType s) := InValidFT_invalid_location_type(s);
EXPORT InValidMessage_location_type(UNSIGNED1 wh) := InValidMessageFT_invalid_location_type(wh);
EXPORT Make_off_license_nbr_type(SALT31.StrType s0) := MakeFT_invalid_off_license_nbr_type(s0);
EXPORT InValid_off_license_nbr_type(SALT31.StrType s) := InValidFT_invalid_off_license_nbr_type(s);
EXPORT InValidMessage_off_license_nbr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_off_license_nbr_type(wh);
EXPORT Make_brkr_license_nbr(SALT31.StrType s0) := MakeFT_invalid_brkr_license_nbr(s0);
EXPORT InValid_brkr_license_nbr(SALT31.StrType s) := InValidFT_invalid_brkr_license_nbr(s);
EXPORT InValidMessage_brkr_license_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_brkr_license_nbr(wh);
EXPORT Make_brkr_license_nbr_type(SALT31.StrType s0) := MakeFT_invalid_brkr_license_nbr_type(s0);
EXPORT InValid_brkr_license_nbr_type(SALT31.StrType s) := InValidFT_invalid_brkr_license_nbr_type(s);
EXPORT InValidMessage_brkr_license_nbr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_brkr_license_nbr_type(wh);
EXPORT Make_agency_id(SALT31.StrType s0) := MakeFT_invalid_agency_id(s0);
EXPORT InValid_agency_id(SALT31.StrType s) := InValidFT_invalid_agency_id(s);
EXPORT InValidMessage_agency_id(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_id(wh);
EXPORT Make_site_location(SALT31.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_site_location(SALT31.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_site_location(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
EXPORT Make_business_type(SALT31.StrType s0) := MakeFT_invalid_business_type(s0);
EXPORT InValid_business_type(SALT31.StrType s) := InValidFT_invalid_business_type(s);
EXPORT InValidMessage_business_type(UNSIGNED1 wh) := InValidMessageFT_invalid_business_type(wh);
EXPORT Make_name_type(SALT31.StrType s0) := MakeFT_invalid_name_type(s0);
EXPORT InValid_name_type(SALT31.StrType s) := InValidFT_invalid_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type(wh);
EXPORT Make_start_dte(SALT31.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_start_dte(SALT31.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_start_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_is_authorized_license(SALT31.StrType s0) := MakeFT_invalid_is_authorized(s0);
EXPORT InValid_is_authorized_license(SALT31.StrType s) := InValidFT_invalid_is_authorized(s);
EXPORT InValidMessage_is_authorized_license(UNSIGNED1 wh) := InValidMessageFT_invalid_is_authorized(wh);
EXPORT Make_is_authorized_conduct(SALT31.StrType s0) := MakeFT_invalid_is_authorized(s0);
EXPORT InValid_is_authorized_conduct(SALT31.StrType s) := InValidFT_invalid_is_authorized(s);
EXPORT InValidMessage_is_authorized_conduct(UNSIGNED1 wh) := InValidMessageFT_invalid_is_authorized(wh);
EXPORT Make_federal_regulator(SALT31.StrType s0) := MakeFT_invalid_federal_regulator(s0);
EXPORT InValid_federal_regulator(SALT31.StrType s) := InValidFT_invalid_federal_regulator(s);
EXPORT InValidMessage_federal_regulator(UNSIGNED1 wh) := InValidMessageFT_invalid_federal_regulator(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Prof_License_Mari;
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
    BOOLEAN Diff_primary_key;
    BOOLEAN Diff_create_dte;
    BOOLEAN Diff_last_upd_dte;
    BOOLEAN Diff_stamp_dte;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_gen_nbr;
    BOOLEAN Diff_std_prof_cd;
    BOOLEAN Diff_std_prof_desc;
    BOOLEAN Diff_std_source_upd;
    BOOLEAN Diff_std_source_desc;
    BOOLEAN Diff_type_cd;
    BOOLEAN Diff_name_org_prefx;
    BOOLEAN Diff_name_org;
    BOOLEAN Diff_name_org_sufx;
    BOOLEAN Diff_store_nbr;
    BOOLEAN Diff_name_dba_prefx;
    BOOLEAN Diff_name_dba;
    BOOLEAN Diff_name_dba_sufx;
    BOOLEAN Diff_store_nbr_dba;
    BOOLEAN Diff_dba_flag;
    BOOLEAN Diff_name_office;
    BOOLEAN Diff_office_parse;
    BOOLEAN Diff_name_prefx;
    BOOLEAN Diff_name_first;
    BOOLEAN Diff_name_mid;
    BOOLEAN Diff_name_last;
    BOOLEAN Diff_name_sufx;
    BOOLEAN Diff_name_nick;
    BOOLEAN Diff_birth_dte;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_prov_stat;
    BOOLEAN Diff_credential;
    BOOLEAN Diff_license_nbr;
    BOOLEAN Diff_off_license_nbr;
    BOOLEAN Diff_prev_license_nbr;
    BOOLEAN Diff_prev_license_type;
    BOOLEAN Diff_license_state;
    BOOLEAN Diff_raw_license_type;
    BOOLEAN Diff_std_license_type;
    BOOLEAN Diff_std_license_desc;
    BOOLEAN Diff_raw_license_status;
    BOOLEAN Diff_std_license_status;
    BOOLEAN Diff_std_status_desc;
    BOOLEAN Diff_curr_issue_dte;
    BOOLEAN Diff_orig_issue_dte;
    BOOLEAN Diff_expire_dte;
    BOOLEAN Diff_renewal_dte;
    BOOLEAN Diff_active_flag;
    BOOLEAN Diff_ssn_taxid_1;
    BOOLEAN Diff_tax_type_1;
    BOOLEAN Diff_ssn_taxid_2;
    BOOLEAN Diff_tax_type_2;
    BOOLEAN Diff_fed_rssd;
    BOOLEAN Diff_addr_bus_ind;
    BOOLEAN Diff_name_format;
    BOOLEAN Diff_name_org_orig;
    BOOLEAN Diff_name_dba_orig;
    BOOLEAN Diff_name_mari_org;
    BOOLEAN Diff_name_mari_dba;
    BOOLEAN Diff_phn_mari_1;
    BOOLEAN Diff_phn_mari_fax_1;
    BOOLEAN Diff_phn_mari_2;
    BOOLEAN Diff_phn_mari_fax_2;
    BOOLEAN Diff_addr_addr1_1;
    BOOLEAN Diff_addr_addr2_1;
    BOOLEAN Diff_addr_addr3_1;
    BOOLEAN Diff_addr_addr4_1;
    BOOLEAN Diff_addr_city_1;
    BOOLEAN Diff_addr_state_1;
    BOOLEAN Diff_addr_zip5_1;
    BOOLEAN Diff_addr_zip4_1;
    BOOLEAN Diff_phn_phone_1;
    BOOLEAN Diff_phn_fax_1;
    BOOLEAN Diff_addr_cnty_1;
    BOOLEAN Diff_addr_cntry_1;
    BOOLEAN Diff_sud_key_1;
    BOOLEAN Diff_ooc_ind_1;
    BOOLEAN Diff_addr_mail_ind;
    BOOLEAN Diff_addr_addr1_2;
    BOOLEAN Diff_addr_addr2_2;
    BOOLEAN Diff_addr_addr3_2;
    BOOLEAN Diff_addr_addr4_2;
    BOOLEAN Diff_addr_city_2;
    BOOLEAN Diff_addr_state_2;
    BOOLEAN Diff_addr_zip5_2;
    BOOLEAN Diff_addr_zip4_2;
    BOOLEAN Diff_addr_cnty_2;
    BOOLEAN Diff_addr_cntry_2;
    BOOLEAN Diff_phn_phone_2;
    BOOLEAN Diff_phn_fax_2;
    BOOLEAN Diff_sud_key_2;
    BOOLEAN Diff_ooc_ind_2;
    BOOLEAN Diff_license_nbr_contact;
    BOOLEAN Diff_name_contact_prefx;
    BOOLEAN Diff_name_contact_first;
    BOOLEAN Diff_name_contact_mid;
    BOOLEAN Diff_name_contact_last;
    BOOLEAN Diff_name_contact_sufx;
    BOOLEAN Diff_name_contact_nick;
    BOOLEAN Diff_name_contact_ttl;
    BOOLEAN Diff_phn_contact;
    BOOLEAN Diff_phn_contact_ext;
    BOOLEAN Diff_phn_contact_fax;
    BOOLEAN Diff_email;
    BOOLEAN Diff_url;
    BOOLEAN Diff_bk_class;
    BOOLEAN Diff_bk_class_desc;
    BOOLEAN Diff_charter;
    BOOLEAN Diff_inst_beg_dte;
    BOOLEAN Diff_origin_cd;
    BOOLEAN Diff_origin_cd_desc;
    BOOLEAN Diff_disp_type_cd;
    BOOLEAN Diff_disp_type_desc;
    BOOLEAN Diff_reg_agent;
    BOOLEAN Diff_regulator;
    BOOLEAN Diff_hqtr_city;
    BOOLEAN Diff_hqtr_name;
    BOOLEAN Diff_domestic_off_nbr;
    BOOLEAN Diff_foreign_off_nbr;
    BOOLEAN Diff_hcr_rssd;
    BOOLEAN Diff_hcr_location;
    BOOLEAN Diff_affil_type_cd;
    BOOLEAN Diff_genlink;
    BOOLEAN Diff_research_ind;
    BOOLEAN Diff_docket_id;
    BOOLEAN Diff_mltreckey;
    BOOLEAN Diff_cmc_slpk;
    BOOLEAN Diff_pcmc_slpk;
    BOOLEAN Diff_affil_key;
    BOOLEAN Diff_provnote_1;
    BOOLEAN Diff_provnote_2;
    BOOLEAN Diff_provnote_3;
    BOOLEAN Diff_action_taken_ind;
    BOOLEAN Diff_viol_type;
    BOOLEAN Diff_viol_cd;
    BOOLEAN Diff_viol_desc;
    BOOLEAN Diff_viol_dte;
    BOOLEAN Diff_viol_case_nbr;
    BOOLEAN Diff_viol_eff_dte;
    BOOLEAN Diff_action_final_nbr;
    BOOLEAN Diff_action_status;
    BOOLEAN Diff_action_status_dte;
    BOOLEAN Diff_displinary_action;
    BOOLEAN Diff_action_file_name;
    BOOLEAN Diff_occupation;
    BOOLEAN Diff_practice_hrs;
    BOOLEAN Diff_practice_type;
    BOOLEAN Diff_misc_other_id;
    BOOLEAN Diff_misc_other_type;
    BOOLEAN Diff_cont_education_ernd;
    BOOLEAN Diff_cont_education_req;
    BOOLEAN Diff_cont_education_term;
    BOOLEAN Diff_schl_attend_1;
    BOOLEAN Diff_schl_attend_dte_1;
    BOOLEAN Diff_schl_curriculum_1;
    BOOLEAN Diff_schl_degree_1;
    BOOLEAN Diff_schl_attend_2;
    BOOLEAN Diff_schl_attend_dte_2;
    BOOLEAN Diff_schl_curriculum_2;
    BOOLEAN Diff_schl_degree_2;
    BOOLEAN Diff_schl_attend_3;
    BOOLEAN Diff_schl_attend_dte_3;
    BOOLEAN Diff_schl_curriculum_3;
    BOOLEAN Diff_schl_degree_3;
    BOOLEAN Diff_addl_license_spec;
    BOOLEAN Diff_place_birth_cd;
    BOOLEAN Diff_place_birth_desc;
    BOOLEAN Diff_race_cd;
    BOOLEAN Diff_std_race_cd;
    BOOLEAN Diff_race_desc;
    BOOLEAN Diff_status_effect_dte;
    BOOLEAN Diff_status_renew_desc;
    BOOLEAN Diff_agency_status;
    BOOLEAN Diff_prev_primary_key;
    BOOLEAN Diff_prev_mltreckey;
    BOOLEAN Diff_prev_cmc_slpk;
    BOOLEAN Diff_prev_pcmc_slpk;
    BOOLEAN Diff_license_id;
    BOOLEAN Diff_nmls_id;
    BOOLEAN Diff_foreign_nmls_id;
    BOOLEAN Diff_location_type;
    BOOLEAN Diff_off_license_nbr_type;
    BOOLEAN Diff_brkr_license_nbr;
    BOOLEAN Diff_brkr_license_nbr_type;
    BOOLEAN Diff_agency_id;
    BOOLEAN Diff_site_location;
    BOOLEAN Diff_business_type;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_start_dte;
    BOOLEAN Diff_is_authorized_license;
    BOOLEAN Diff_is_authorized_conduct;
    BOOLEAN Diff_federal_regulator;
    SALT31.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_primary_key := le.primary_key <> ri.primary_key;
    SELF.Diff_create_dte := le.create_dte <> ri.create_dte;
    SELF.Diff_last_upd_dte := le.last_upd_dte <> ri.last_upd_dte;
    SELF.Diff_stamp_dte := le.stamp_dte <> ri.stamp_dte;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_gen_nbr := le.gen_nbr <> ri.gen_nbr;
    SELF.Diff_std_prof_cd := le.std_prof_cd <> ri.std_prof_cd;
    SELF.Diff_std_prof_desc := le.std_prof_desc <> ri.std_prof_desc;
    SELF.Diff_std_source_upd := le.std_source_upd <> ri.std_source_upd;
    SELF.Diff_std_source_desc := le.std_source_desc <> ri.std_source_desc;
    SELF.Diff_type_cd := le.type_cd <> ri.type_cd;
    SELF.Diff_name_org_prefx := le.name_org_prefx <> ri.name_org_prefx;
    SELF.Diff_name_org := le.name_org <> ri.name_org;
    SELF.Diff_name_org_sufx := le.name_org_sufx <> ri.name_org_sufx;
    SELF.Diff_store_nbr := le.store_nbr <> ri.store_nbr;
    SELF.Diff_name_dba_prefx := le.name_dba_prefx <> ri.name_dba_prefx;
    SELF.Diff_name_dba := le.name_dba <> ri.name_dba;
    SELF.Diff_name_dba_sufx := le.name_dba_sufx <> ri.name_dba_sufx;
    SELF.Diff_store_nbr_dba := le.store_nbr_dba <> ri.store_nbr_dba;
    SELF.Diff_dba_flag := le.dba_flag <> ri.dba_flag;
    SELF.Diff_name_office := le.name_office <> ri.name_office;
    SELF.Diff_office_parse := le.office_parse <> ri.office_parse;
    SELF.Diff_name_prefx := le.name_prefx <> ri.name_prefx;
    SELF.Diff_name_first := le.name_first <> ri.name_first;
    SELF.Diff_name_mid := le.name_mid <> ri.name_mid;
    SELF.Diff_name_last := le.name_last <> ri.name_last;
    SELF.Diff_name_sufx := le.name_sufx <> ri.name_sufx;
    SELF.Diff_name_nick := le.name_nick <> ri.name_nick;
    SELF.Diff_birth_dte := le.birth_dte <> ri.birth_dte;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_prov_stat := le.prov_stat <> ri.prov_stat;
    SELF.Diff_credential := le.credential <> ri.credential;
    SELF.Diff_license_nbr := le.license_nbr <> ri.license_nbr;
    SELF.Diff_off_license_nbr := le.off_license_nbr <> ri.off_license_nbr;
    SELF.Diff_prev_license_nbr := le.prev_license_nbr <> ri.prev_license_nbr;
    SELF.Diff_prev_license_type := le.prev_license_type <> ri.prev_license_type;
    SELF.Diff_license_state := le.license_state <> ri.license_state;
    SELF.Diff_raw_license_type := le.raw_license_type <> ri.raw_license_type;
    SELF.Diff_std_license_type := le.std_license_type <> ri.std_license_type;
    SELF.Diff_std_license_desc := le.std_license_desc <> ri.std_license_desc;
    SELF.Diff_raw_license_status := le.raw_license_status <> ri.raw_license_status;
    SELF.Diff_std_license_status := le.std_license_status <> ri.std_license_status;
    SELF.Diff_std_status_desc := le.std_status_desc <> ri.std_status_desc;
    SELF.Diff_curr_issue_dte := le.curr_issue_dte <> ri.curr_issue_dte;
    SELF.Diff_orig_issue_dte := le.orig_issue_dte <> ri.orig_issue_dte;
    SELF.Diff_expire_dte := le.expire_dte <> ri.expire_dte;
    SELF.Diff_renewal_dte := le.renewal_dte <> ri.renewal_dte;
    SELF.Diff_active_flag := le.active_flag <> ri.active_flag;
    SELF.Diff_ssn_taxid_1 := le.ssn_taxid_1 <> ri.ssn_taxid_1;
    SELF.Diff_tax_type_1 := le.tax_type_1 <> ri.tax_type_1;
    SELF.Diff_ssn_taxid_2 := le.ssn_taxid_2 <> ri.ssn_taxid_2;
    SELF.Diff_tax_type_2 := le.tax_type_2 <> ri.tax_type_2;
    SELF.Diff_fed_rssd := le.fed_rssd <> ri.fed_rssd;
    SELF.Diff_addr_bus_ind := le.addr_bus_ind <> ri.addr_bus_ind;
    SELF.Diff_name_format := le.name_format <> ri.name_format;
    SELF.Diff_name_org_orig := le.name_org_orig <> ri.name_org_orig;
    SELF.Diff_name_dba_orig := le.name_dba_orig <> ri.name_dba_orig;
    SELF.Diff_name_mari_org := le.name_mari_org <> ri.name_mari_org;
    SELF.Diff_name_mari_dba := le.name_mari_dba <> ri.name_mari_dba;
    SELF.Diff_phn_mari_1 := le.phn_mari_1 <> ri.phn_mari_1;
    SELF.Diff_phn_mari_fax_1 := le.phn_mari_fax_1 <> ri.phn_mari_fax_1;
    SELF.Diff_phn_mari_2 := le.phn_mari_2 <> ri.phn_mari_2;
    SELF.Diff_phn_mari_fax_2 := le.phn_mari_fax_2 <> ri.phn_mari_fax_2;
    SELF.Diff_addr_addr1_1 := le.addr_addr1_1 <> ri.addr_addr1_1;
    SELF.Diff_addr_addr2_1 := le.addr_addr2_1 <> ri.addr_addr2_1;
    SELF.Diff_addr_addr3_1 := le.addr_addr3_1 <> ri.addr_addr3_1;
    SELF.Diff_addr_addr4_1 := le.addr_addr4_1 <> ri.addr_addr4_1;
    SELF.Diff_addr_city_1 := le.addr_city_1 <> ri.addr_city_1;
    SELF.Diff_addr_state_1 := le.addr_state_1 <> ri.addr_state_1;
    SELF.Diff_addr_zip5_1 := le.addr_zip5_1 <> ri.addr_zip5_1;
    SELF.Diff_addr_zip4_1 := le.addr_zip4_1 <> ri.addr_zip4_1;
    SELF.Diff_phn_phone_1 := le.phn_phone_1 <> ri.phn_phone_1;
    SELF.Diff_phn_fax_1 := le.phn_fax_1 <> ri.phn_fax_1;
    SELF.Diff_addr_cnty_1 := le.addr_cnty_1 <> ri.addr_cnty_1;
    SELF.Diff_addr_cntry_1 := le.addr_cntry_1 <> ri.addr_cntry_1;
    SELF.Diff_sud_key_1 := le.sud_key_1 <> ri.sud_key_1;
    SELF.Diff_ooc_ind_1 := le.ooc_ind_1 <> ri.ooc_ind_1;
    SELF.Diff_addr_mail_ind := le.addr_mail_ind <> ri.addr_mail_ind;
    SELF.Diff_addr_addr1_2 := le.addr_addr1_2 <> ri.addr_addr1_2;
    SELF.Diff_addr_addr2_2 := le.addr_addr2_2 <> ri.addr_addr2_2;
    SELF.Diff_addr_addr3_2 := le.addr_addr3_2 <> ri.addr_addr3_2;
    SELF.Diff_addr_addr4_2 := le.addr_addr4_2 <> ri.addr_addr4_2;
    SELF.Diff_addr_city_2 := le.addr_city_2 <> ri.addr_city_2;
    SELF.Diff_addr_state_2 := le.addr_state_2 <> ri.addr_state_2;
    SELF.Diff_addr_zip5_2 := le.addr_zip5_2 <> ri.addr_zip5_2;
    SELF.Diff_addr_zip4_2 := le.addr_zip4_2 <> ri.addr_zip4_2;
    SELF.Diff_addr_cnty_2 := le.addr_cnty_2 <> ri.addr_cnty_2;
    SELF.Diff_addr_cntry_2 := le.addr_cntry_2 <> ri.addr_cntry_2;
    SELF.Diff_phn_phone_2 := le.phn_phone_2 <> ri.phn_phone_2;
    SELF.Diff_phn_fax_2 := le.phn_fax_2 <> ri.phn_fax_2;
    SELF.Diff_sud_key_2 := le.sud_key_2 <> ri.sud_key_2;
    SELF.Diff_ooc_ind_2 := le.ooc_ind_2 <> ri.ooc_ind_2;
    SELF.Diff_license_nbr_contact := le.license_nbr_contact <> ri.license_nbr_contact;
    SELF.Diff_name_contact_prefx := le.name_contact_prefx <> ri.name_contact_prefx;
    SELF.Diff_name_contact_first := le.name_contact_first <> ri.name_contact_first;
    SELF.Diff_name_contact_mid := le.name_contact_mid <> ri.name_contact_mid;
    SELF.Diff_name_contact_last := le.name_contact_last <> ri.name_contact_last;
    SELF.Diff_name_contact_sufx := le.name_contact_sufx <> ri.name_contact_sufx;
    SELF.Diff_name_contact_nick := le.name_contact_nick <> ri.name_contact_nick;
    SELF.Diff_name_contact_ttl := le.name_contact_ttl <> ri.name_contact_ttl;
    SELF.Diff_phn_contact := le.phn_contact <> ri.phn_contact;
    SELF.Diff_phn_contact_ext := le.phn_contact_ext <> ri.phn_contact_ext;
    SELF.Diff_phn_contact_fax := le.phn_contact_fax <> ri.phn_contact_fax;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_bk_class := le.bk_class <> ri.bk_class;
    SELF.Diff_bk_class_desc := le.bk_class_desc <> ri.bk_class_desc;
    SELF.Diff_charter := le.charter <> ri.charter;
    SELF.Diff_inst_beg_dte := le.inst_beg_dte <> ri.inst_beg_dte;
    SELF.Diff_origin_cd := le.origin_cd <> ri.origin_cd;
    SELF.Diff_origin_cd_desc := le.origin_cd_desc <> ri.origin_cd_desc;
    SELF.Diff_disp_type_cd := le.disp_type_cd <> ri.disp_type_cd;
    SELF.Diff_disp_type_desc := le.disp_type_desc <> ri.disp_type_desc;
    SELF.Diff_reg_agent := le.reg_agent <> ri.reg_agent;
    SELF.Diff_regulator := le.regulator <> ri.regulator;
    SELF.Diff_hqtr_city := le.hqtr_city <> ri.hqtr_city;
    SELF.Diff_hqtr_name := le.hqtr_name <> ri.hqtr_name;
    SELF.Diff_domestic_off_nbr := le.domestic_off_nbr <> ri.domestic_off_nbr;
    SELF.Diff_foreign_off_nbr := le.foreign_off_nbr <> ri.foreign_off_nbr;
    SELF.Diff_hcr_rssd := le.hcr_rssd <> ri.hcr_rssd;
    SELF.Diff_hcr_location := le.hcr_location <> ri.hcr_location;
    SELF.Diff_affil_type_cd := le.affil_type_cd <> ri.affil_type_cd;
    SELF.Diff_genlink := le.genlink <> ri.genlink;
    SELF.Diff_research_ind := le.research_ind <> ri.research_ind;
    SELF.Diff_docket_id := le.docket_id <> ri.docket_id;
    SELF.Diff_mltreckey := le.mltreckey <> ri.mltreckey;
    SELF.Diff_cmc_slpk := le.cmc_slpk <> ri.cmc_slpk;
    SELF.Diff_pcmc_slpk := le.pcmc_slpk <> ri.pcmc_slpk;
    SELF.Diff_affil_key := le.affil_key <> ri.affil_key;
    SELF.Diff_provnote_1 := le.provnote_1 <> ri.provnote_1;
    SELF.Diff_provnote_2 := le.provnote_2 <> ri.provnote_2;
    SELF.Diff_provnote_3 := le.provnote_3 <> ri.provnote_3;
    SELF.Diff_action_taken_ind := le.action_taken_ind <> ri.action_taken_ind;
    SELF.Diff_viol_type := le.viol_type <> ri.viol_type;
    SELF.Diff_viol_cd := le.viol_cd <> ri.viol_cd;
    SELF.Diff_viol_desc := le.viol_desc <> ri.viol_desc;
    SELF.Diff_viol_dte := le.viol_dte <> ri.viol_dte;
    SELF.Diff_viol_case_nbr := le.viol_case_nbr <> ri.viol_case_nbr;
    SELF.Diff_viol_eff_dte := le.viol_eff_dte <> ri.viol_eff_dte;
    SELF.Diff_action_final_nbr := le.action_final_nbr <> ri.action_final_nbr;
    SELF.Diff_action_status := le.action_status <> ri.action_status;
    SELF.Diff_action_status_dte := le.action_status_dte <> ri.action_status_dte;
    SELF.Diff_displinary_action := le.displinary_action <> ri.displinary_action;
    SELF.Diff_action_file_name := le.action_file_name <> ri.action_file_name;
    SELF.Diff_occupation := le.occupation <> ri.occupation;
    SELF.Diff_practice_hrs := le.practice_hrs <> ri.practice_hrs;
    SELF.Diff_practice_type := le.practice_type <> ri.practice_type;
    SELF.Diff_misc_other_id := le.misc_other_id <> ri.misc_other_id;
    SELF.Diff_misc_other_type := le.misc_other_type <> ri.misc_other_type;
    SELF.Diff_cont_education_ernd := le.cont_education_ernd <> ri.cont_education_ernd;
    SELF.Diff_cont_education_req := le.cont_education_req <> ri.cont_education_req;
    SELF.Diff_cont_education_term := le.cont_education_term <> ri.cont_education_term;
    SELF.Diff_schl_attend_1 := le.schl_attend_1 <> ri.schl_attend_1;
    SELF.Diff_schl_attend_dte_1 := le.schl_attend_dte_1 <> ri.schl_attend_dte_1;
    SELF.Diff_schl_curriculum_1 := le.schl_curriculum_1 <> ri.schl_curriculum_1;
    SELF.Diff_schl_degree_1 := le.schl_degree_1 <> ri.schl_degree_1;
    SELF.Diff_schl_attend_2 := le.schl_attend_2 <> ri.schl_attend_2;
    SELF.Diff_schl_attend_dte_2 := le.schl_attend_dte_2 <> ri.schl_attend_dte_2;
    SELF.Diff_schl_curriculum_2 := le.schl_curriculum_2 <> ri.schl_curriculum_2;
    SELF.Diff_schl_degree_2 := le.schl_degree_2 <> ri.schl_degree_2;
    SELF.Diff_schl_attend_3 := le.schl_attend_3 <> ri.schl_attend_3;
    SELF.Diff_schl_attend_dte_3 := le.schl_attend_dte_3 <> ri.schl_attend_dte_3;
    SELF.Diff_schl_curriculum_3 := le.schl_curriculum_3 <> ri.schl_curriculum_3;
    SELF.Diff_schl_degree_3 := le.schl_degree_3 <> ri.schl_degree_3;
    SELF.Diff_addl_license_spec := le.addl_license_spec <> ri.addl_license_spec;
    SELF.Diff_place_birth_cd := le.place_birth_cd <> ri.place_birth_cd;
    SELF.Diff_place_birth_desc := le.place_birth_desc <> ri.place_birth_desc;
    SELF.Diff_race_cd := le.race_cd <> ri.race_cd;
    SELF.Diff_std_race_cd := le.std_race_cd <> ri.std_race_cd;
    SELF.Diff_race_desc := le.race_desc <> ri.race_desc;
    SELF.Diff_status_effect_dte := le.status_effect_dte <> ri.status_effect_dte;
    SELF.Diff_status_renew_desc := le.status_renew_desc <> ri.status_renew_desc;
    SELF.Diff_agency_status := le.agency_status <> ri.agency_status;
    SELF.Diff_prev_primary_key := le.prev_primary_key <> ri.prev_primary_key;
    SELF.Diff_prev_mltreckey := le.prev_mltreckey <> ri.prev_mltreckey;
    SELF.Diff_prev_cmc_slpk := le.prev_cmc_slpk <> ri.prev_cmc_slpk;
    SELF.Diff_prev_pcmc_slpk := le.prev_pcmc_slpk <> ri.prev_pcmc_slpk;
    SELF.Diff_license_id := le.license_id <> ri.license_id;
    SELF.Diff_nmls_id := le.nmls_id <> ri.nmls_id;
    SELF.Diff_foreign_nmls_id := le.foreign_nmls_id <> ri.foreign_nmls_id;
    SELF.Diff_location_type := le.location_type <> ri.location_type;
    SELF.Diff_off_license_nbr_type := le.off_license_nbr_type <> ri.off_license_nbr_type;
    SELF.Diff_brkr_license_nbr := le.brkr_license_nbr <> ri.brkr_license_nbr;
    SELF.Diff_brkr_license_nbr_type := le.brkr_license_nbr_type <> ri.brkr_license_nbr_type;
    SELF.Diff_agency_id := le.agency_id <> ri.agency_id;
    SELF.Diff_site_location := le.site_location <> ri.site_location;
    SELF.Diff_business_type := le.business_type <> ri.business_type;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_start_dte := le.start_dte <> ri.start_dte;
    SELF.Diff_is_authorized_license := le.is_authorized_license <> ri.is_authorized_license;
    SELF.Diff_is_authorized_conduct := le.is_authorized_conduct <> ri.is_authorized_conduct;
    SELF.Diff_federal_regulator := le.federal_regulator <> ri.federal_regulator;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.std_source_upd;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_primary_key,1,0)+ IF( SELF.Diff_create_dte,1,0)+ IF( SELF.Diff_last_upd_dte,1,0)+ IF( SELF.Diff_stamp_dte,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_gen_nbr,1,0)+ IF( SELF.Diff_std_prof_cd,1,0)+ IF( SELF.Diff_std_prof_desc,1,0)+ IF( SELF.Diff_std_source_upd,1,0)+ IF( SELF.Diff_std_source_desc,1,0)+ IF( SELF.Diff_type_cd,1,0)+ IF( SELF.Diff_name_org_prefx,1,0)+ IF( SELF.Diff_name_org,1,0)+ IF( SELF.Diff_name_org_sufx,1,0)+ IF( SELF.Diff_store_nbr,1,0)+ IF( SELF.Diff_name_dba_prefx,1,0)+ IF( SELF.Diff_name_dba,1,0)+ IF( SELF.Diff_name_dba_sufx,1,0)+ IF( SELF.Diff_store_nbr_dba,1,0)+ IF( SELF.Diff_dba_flag,1,0)+ IF( SELF.Diff_name_office,1,0)+ IF( SELF.Diff_office_parse,1,0)+ IF( SELF.Diff_name_prefx,1,0)+ IF( SELF.Diff_name_first,1,0)+ IF( SELF.Diff_name_mid,1,0)+ IF( SELF.Diff_name_last,1,0)+ IF( SELF.Diff_name_sufx,1,0)+ IF( SELF.Diff_name_nick,1,0)+ IF( SELF.Diff_birth_dte,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_prov_stat,1,0)+ IF( SELF.Diff_credential,1,0)+ IF( SELF.Diff_license_nbr,1,0)+ IF( SELF.Diff_off_license_nbr,1,0)+ IF( SELF.Diff_prev_license_nbr,1,0)+ IF( SELF.Diff_prev_license_type,1,0)+ IF( SELF.Diff_license_state,1,0)+ IF( SELF.Diff_raw_license_type,1,0)+ IF( SELF.Diff_std_license_type,1,0)+ IF( SELF.Diff_std_license_desc,1,0)+ IF( SELF.Diff_raw_license_status,1,0)+ IF( SELF.Diff_std_license_status,1,0)+ IF( SELF.Diff_std_status_desc,1,0)+ IF( SELF.Diff_curr_issue_dte,1,0)+ IF( SELF.Diff_orig_issue_dte,1,0)+ IF( SELF.Diff_expire_dte,1,0)+ IF( SELF.Diff_renewal_dte,1,0)+ IF( SELF.Diff_active_flag,1,0)+ IF( SELF.Diff_ssn_taxid_1,1,0)+ IF( SELF.Diff_tax_type_1,1,0)+ IF( SELF.Diff_ssn_taxid_2,1,0)+ IF( SELF.Diff_tax_type_2,1,0)+ IF( SELF.Diff_fed_rssd,1,0)+ IF( SELF.Diff_addr_bus_ind,1,0)+ IF( SELF.Diff_name_format,1,0)+ IF( SELF.Diff_name_org_orig,1,0)+ IF( SELF.Diff_name_dba_orig,1,0)+ IF( SELF.Diff_name_mari_org,1,0)+ IF( SELF.Diff_name_mari_dba,1,0)+ IF( SELF.Diff_phn_mari_1,1,0)+ IF( SELF.Diff_phn_mari_fax_1,1,0)+ IF( SELF.Diff_phn_mari_2,1,0)+ IF( SELF.Diff_phn_mari_fax_2,1,0)+ IF( SELF.Diff_addr_addr1_1,1,0)+ IF( SELF.Diff_addr_addr2_1,1,0)+ IF( SELF.Diff_addr_addr3_1,1,0)+ IF( SELF.Diff_addr_addr4_1,1,0)+ IF( SELF.Diff_addr_city_1,1,0)+ IF( SELF.Diff_addr_state_1,1,0)+ IF( SELF.Diff_addr_zip5_1,1,0)+ IF( SELF.Diff_addr_zip4_1,1,0)+ IF( SELF.Diff_phn_phone_1,1,0)+ IF( SELF.Diff_phn_fax_1,1,0)+ IF( SELF.Diff_addr_cnty_1,1,0)+ IF( SELF.Diff_addr_cntry_1,1,0)+ IF( SELF.Diff_sud_key_1,1,0)+ IF( SELF.Diff_ooc_ind_1,1,0)+ IF( SELF.Diff_addr_mail_ind,1,0)+ IF( SELF.Diff_addr_addr1_2,1,0)+ IF( SELF.Diff_addr_addr2_2,1,0)+ IF( SELF.Diff_addr_addr3_2,1,0)+ IF( SELF.Diff_addr_addr4_2,1,0)+ IF( SELF.Diff_addr_city_2,1,0)+ IF( SELF.Diff_addr_state_2,1,0)+ IF( SELF.Diff_addr_zip5_2,1,0)+ IF( SELF.Diff_addr_zip4_2,1,0)+ IF( SELF.Diff_addr_cnty_2,1,0)+ IF( SELF.Diff_addr_cntry_2,1,0)+ IF( SELF.Diff_phn_phone_2,1,0)+ IF( SELF.Diff_phn_fax_2,1,0)+ IF( SELF.Diff_sud_key_2,1,0)+ IF( SELF.Diff_ooc_ind_2,1,0)+ IF( SELF.Diff_license_nbr_contact,1,0)+ IF( SELF.Diff_name_contact_prefx,1,0)+ IF( SELF.Diff_name_contact_first,1,0)+ IF( SELF.Diff_name_contact_mid,1,0)+ IF( SELF.Diff_name_contact_last,1,0)+ IF( SELF.Diff_name_contact_sufx,1,0)+ IF( SELF.Diff_name_contact_nick,1,0)+ IF( SELF.Diff_name_contact_ttl,1,0)+ IF( SELF.Diff_phn_contact,1,0)+ IF( SELF.Diff_phn_contact_ext,1,0)+ IF( SELF.Diff_phn_contact_fax,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_bk_class,1,0)+ IF( SELF.Diff_bk_class_desc,1,0)+ IF( SELF.Diff_charter,1,0)+ IF( SELF.Diff_inst_beg_dte,1,0)+ IF( SELF.Diff_origin_cd,1,0)+ IF( SELF.Diff_origin_cd_desc,1,0)+ IF( SELF.Diff_disp_type_cd,1,0)+ IF( SELF.Diff_disp_type_desc,1,0)+ IF( SELF.Diff_reg_agent,1,0)+ IF( SELF.Diff_regulator,1,0)+ IF( SELF.Diff_hqtr_city,1,0)+ IF( SELF.Diff_hqtr_name,1,0)+ IF( SELF.Diff_domestic_off_nbr,1,0)+ IF( SELF.Diff_foreign_off_nbr,1,0)+ IF( SELF.Diff_hcr_rssd,1,0)+ IF( SELF.Diff_hcr_location,1,0)+ IF( SELF.Diff_affil_type_cd,1,0)+ IF( SELF.Diff_genlink,1,0)+ IF( SELF.Diff_research_ind,1,0)+ IF( SELF.Diff_docket_id,1,0)+ IF( SELF.Diff_mltreckey,1,0)+ IF( SELF.Diff_cmc_slpk,1,0)+ IF( SELF.Diff_pcmc_slpk,1,0)+ IF( SELF.Diff_affil_key,1,0)+ IF( SELF.Diff_provnote_1,1,0)+ IF( SELF.Diff_provnote_2,1,0)+ IF( SELF.Diff_provnote_3,1,0)+ IF( SELF.Diff_action_taken_ind,1,0)+ IF( SELF.Diff_viol_type,1,0)+ IF( SELF.Diff_viol_cd,1,0)+ IF( SELF.Diff_viol_desc,1,0)+ IF( SELF.Diff_viol_dte,1,0)+ IF( SELF.Diff_viol_case_nbr,1,0)+ IF( SELF.Diff_viol_eff_dte,1,0)+ IF( SELF.Diff_action_final_nbr,1,0)+ IF( SELF.Diff_action_status,1,0)+ IF( SELF.Diff_action_status_dte,1,0)+ IF( SELF.Diff_displinary_action,1,0)+ IF( SELF.Diff_action_file_name,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_practice_hrs,1,0)+ IF( SELF.Diff_practice_type,1,0)+ IF( SELF.Diff_misc_other_id,1,0)+ IF( SELF.Diff_misc_other_type,1,0)+ IF( SELF.Diff_cont_education_ernd,1,0)+ IF( SELF.Diff_cont_education_req,1,0)+ IF( SELF.Diff_cont_education_term,1,0)+ IF( SELF.Diff_schl_attend_1,1,0)+ IF( SELF.Diff_schl_attend_dte_1,1,0)+ IF( SELF.Diff_schl_curriculum_1,1,0)+ IF( SELF.Diff_schl_degree_1,1,0)+ IF( SELF.Diff_schl_attend_2,1,0)+ IF( SELF.Diff_schl_attend_dte_2,1,0)+ IF( SELF.Diff_schl_curriculum_2,1,0)+ IF( SELF.Diff_schl_degree_2,1,0)+ IF( SELF.Diff_schl_attend_3,1,0)+ IF( SELF.Diff_schl_attend_dte_3,1,0)+ IF( SELF.Diff_schl_curriculum_3,1,0)+ IF( SELF.Diff_schl_degree_3,1,0)+ IF( SELF.Diff_addl_license_spec,1,0)+ IF( SELF.Diff_place_birth_cd,1,0)+ IF( SELF.Diff_place_birth_desc,1,0)+ IF( SELF.Diff_race_cd,1,0)+ IF( SELF.Diff_std_race_cd,1,0)+ IF( SELF.Diff_race_desc,1,0)+ IF( SELF.Diff_status_effect_dte,1,0)+ IF( SELF.Diff_status_renew_desc,1,0)+ IF( SELF.Diff_agency_status,1,0)+ IF( SELF.Diff_prev_primary_key,1,0)+ IF( SELF.Diff_prev_mltreckey,1,0)+ IF( SELF.Diff_prev_cmc_slpk,1,0)+ IF( SELF.Diff_prev_pcmc_slpk,1,0)+ IF( SELF.Diff_license_id,1,0)+ IF( SELF.Diff_nmls_id,1,0)+ IF( SELF.Diff_foreign_nmls_id,1,0)+ IF( SELF.Diff_location_type,1,0)+ IF( SELF.Diff_off_license_nbr_type,1,0)+ IF( SELF.Diff_brkr_license_nbr,1,0)+ IF( SELF.Diff_brkr_license_nbr_type,1,0)+ IF( SELF.Diff_agency_id,1,0)+ IF( SELF.Diff_site_location,1,0)+ IF( SELF.Diff_business_type,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_start_dte,1,0)+ IF( SELF.Diff_is_authorized_license,1,0)+ IF( SELF.Diff_is_authorized_conduct,1,0)+ IF( SELF.Diff_federal_regulator,1,0);
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
    Count_Diff_primary_key := COUNT(GROUP,%Closest%.Diff_primary_key);
    Count_Diff_create_dte := COUNT(GROUP,%Closest%.Diff_create_dte);
    Count_Diff_last_upd_dte := COUNT(GROUP,%Closest%.Diff_last_upd_dte);
    Count_Diff_stamp_dte := COUNT(GROUP,%Closest%.Diff_stamp_dte);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_gen_nbr := COUNT(GROUP,%Closest%.Diff_gen_nbr);
    Count_Diff_std_prof_cd := COUNT(GROUP,%Closest%.Diff_std_prof_cd);
    Count_Diff_std_prof_desc := COUNT(GROUP,%Closest%.Diff_std_prof_desc);
    Count_Diff_std_source_upd := COUNT(GROUP,%Closest%.Diff_std_source_upd);
    Count_Diff_std_source_desc := COUNT(GROUP,%Closest%.Diff_std_source_desc);
    Count_Diff_type_cd := COUNT(GROUP,%Closest%.Diff_type_cd);
    Count_Diff_name_org_prefx := COUNT(GROUP,%Closest%.Diff_name_org_prefx);
    Count_Diff_name_org := COUNT(GROUP,%Closest%.Diff_name_org);
    Count_Diff_name_org_sufx := COUNT(GROUP,%Closest%.Diff_name_org_sufx);
    Count_Diff_store_nbr := COUNT(GROUP,%Closest%.Diff_store_nbr);
    Count_Diff_name_dba_prefx := COUNT(GROUP,%Closest%.Diff_name_dba_prefx);
    Count_Diff_name_dba := COUNT(GROUP,%Closest%.Diff_name_dba);
    Count_Diff_name_dba_sufx := COUNT(GROUP,%Closest%.Diff_name_dba_sufx);
    Count_Diff_store_nbr_dba := COUNT(GROUP,%Closest%.Diff_store_nbr_dba);
    Count_Diff_dba_flag := COUNT(GROUP,%Closest%.Diff_dba_flag);
    Count_Diff_name_office := COUNT(GROUP,%Closest%.Diff_name_office);
    Count_Diff_office_parse := COUNT(GROUP,%Closest%.Diff_office_parse);
    Count_Diff_name_prefx := COUNT(GROUP,%Closest%.Diff_name_prefx);
    Count_Diff_name_first := COUNT(GROUP,%Closest%.Diff_name_first);
    Count_Diff_name_mid := COUNT(GROUP,%Closest%.Diff_name_mid);
    Count_Diff_name_last := COUNT(GROUP,%Closest%.Diff_name_last);
    Count_Diff_name_sufx := COUNT(GROUP,%Closest%.Diff_name_sufx);
    Count_Diff_name_nick := COUNT(GROUP,%Closest%.Diff_name_nick);
    Count_Diff_birth_dte := COUNT(GROUP,%Closest%.Diff_birth_dte);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_prov_stat := COUNT(GROUP,%Closest%.Diff_prov_stat);
    Count_Diff_credential := COUNT(GROUP,%Closest%.Diff_credential);
    Count_Diff_license_nbr := COUNT(GROUP,%Closest%.Diff_license_nbr);
    Count_Diff_off_license_nbr := COUNT(GROUP,%Closest%.Diff_off_license_nbr);
    Count_Diff_prev_license_nbr := COUNT(GROUP,%Closest%.Diff_prev_license_nbr);
    Count_Diff_prev_license_type := COUNT(GROUP,%Closest%.Diff_prev_license_type);
    Count_Diff_license_state := COUNT(GROUP,%Closest%.Diff_license_state);
    Count_Diff_raw_license_type := COUNT(GROUP,%Closest%.Diff_raw_license_type);
    Count_Diff_std_license_type := COUNT(GROUP,%Closest%.Diff_std_license_type);
    Count_Diff_std_license_desc := COUNT(GROUP,%Closest%.Diff_std_license_desc);
    Count_Diff_raw_license_status := COUNT(GROUP,%Closest%.Diff_raw_license_status);
    Count_Diff_std_license_status := COUNT(GROUP,%Closest%.Diff_std_license_status);
    Count_Diff_std_status_desc := COUNT(GROUP,%Closest%.Diff_std_status_desc);
    Count_Diff_curr_issue_dte := COUNT(GROUP,%Closest%.Diff_curr_issue_dte);
    Count_Diff_orig_issue_dte := COUNT(GROUP,%Closest%.Diff_orig_issue_dte);
    Count_Diff_expire_dte := COUNT(GROUP,%Closest%.Diff_expire_dte);
    Count_Diff_renewal_dte := COUNT(GROUP,%Closest%.Diff_renewal_dte);
    Count_Diff_active_flag := COUNT(GROUP,%Closest%.Diff_active_flag);
    Count_Diff_ssn_taxid_1 := COUNT(GROUP,%Closest%.Diff_ssn_taxid_1);
    Count_Diff_tax_type_1 := COUNT(GROUP,%Closest%.Diff_tax_type_1);
    Count_Diff_ssn_taxid_2 := COUNT(GROUP,%Closest%.Diff_ssn_taxid_2);
    Count_Diff_tax_type_2 := COUNT(GROUP,%Closest%.Diff_tax_type_2);
    Count_Diff_fed_rssd := COUNT(GROUP,%Closest%.Diff_fed_rssd);
    Count_Diff_addr_bus_ind := COUNT(GROUP,%Closest%.Diff_addr_bus_ind);
    Count_Diff_name_format := COUNT(GROUP,%Closest%.Diff_name_format);
    Count_Diff_name_org_orig := COUNT(GROUP,%Closest%.Diff_name_org_orig);
    Count_Diff_name_dba_orig := COUNT(GROUP,%Closest%.Diff_name_dba_orig);
    Count_Diff_name_mari_org := COUNT(GROUP,%Closest%.Diff_name_mari_org);
    Count_Diff_name_mari_dba := COUNT(GROUP,%Closest%.Diff_name_mari_dba);
    Count_Diff_phn_mari_1 := COUNT(GROUP,%Closest%.Diff_phn_mari_1);
    Count_Diff_phn_mari_fax_1 := COUNT(GROUP,%Closest%.Diff_phn_mari_fax_1);
    Count_Diff_phn_mari_2 := COUNT(GROUP,%Closest%.Diff_phn_mari_2);
    Count_Diff_phn_mari_fax_2 := COUNT(GROUP,%Closest%.Diff_phn_mari_fax_2);
    Count_Diff_addr_addr1_1 := COUNT(GROUP,%Closest%.Diff_addr_addr1_1);
    Count_Diff_addr_addr2_1 := COUNT(GROUP,%Closest%.Diff_addr_addr2_1);
    Count_Diff_addr_addr3_1 := COUNT(GROUP,%Closest%.Diff_addr_addr3_1);
    Count_Diff_addr_addr4_1 := COUNT(GROUP,%Closest%.Diff_addr_addr4_1);
    Count_Diff_addr_city_1 := COUNT(GROUP,%Closest%.Diff_addr_city_1);
    Count_Diff_addr_state_1 := COUNT(GROUP,%Closest%.Diff_addr_state_1);
    Count_Diff_addr_zip5_1 := COUNT(GROUP,%Closest%.Diff_addr_zip5_1);
    Count_Diff_addr_zip4_1 := COUNT(GROUP,%Closest%.Diff_addr_zip4_1);
    Count_Diff_phn_phone_1 := COUNT(GROUP,%Closest%.Diff_phn_phone_1);
    Count_Diff_phn_fax_1 := COUNT(GROUP,%Closest%.Diff_phn_fax_1);
    Count_Diff_addr_cnty_1 := COUNT(GROUP,%Closest%.Diff_addr_cnty_1);
    Count_Diff_addr_cntry_1 := COUNT(GROUP,%Closest%.Diff_addr_cntry_1);
    Count_Diff_sud_key_1 := COUNT(GROUP,%Closest%.Diff_sud_key_1);
    Count_Diff_ooc_ind_1 := COUNT(GROUP,%Closest%.Diff_ooc_ind_1);
    Count_Diff_addr_mail_ind := COUNT(GROUP,%Closest%.Diff_addr_mail_ind);
    Count_Diff_addr_addr1_2 := COUNT(GROUP,%Closest%.Diff_addr_addr1_2);
    Count_Diff_addr_addr2_2 := COUNT(GROUP,%Closest%.Diff_addr_addr2_2);
    Count_Diff_addr_addr3_2 := COUNT(GROUP,%Closest%.Diff_addr_addr3_2);
    Count_Diff_addr_addr4_2 := COUNT(GROUP,%Closest%.Diff_addr_addr4_2);
    Count_Diff_addr_city_2 := COUNT(GROUP,%Closest%.Diff_addr_city_2);
    Count_Diff_addr_state_2 := COUNT(GROUP,%Closest%.Diff_addr_state_2);
    Count_Diff_addr_zip5_2 := COUNT(GROUP,%Closest%.Diff_addr_zip5_2);
    Count_Diff_addr_zip4_2 := COUNT(GROUP,%Closest%.Diff_addr_zip4_2);
    Count_Diff_addr_cnty_2 := COUNT(GROUP,%Closest%.Diff_addr_cnty_2);
    Count_Diff_addr_cntry_2 := COUNT(GROUP,%Closest%.Diff_addr_cntry_2);
    Count_Diff_phn_phone_2 := COUNT(GROUP,%Closest%.Diff_phn_phone_2);
    Count_Diff_phn_fax_2 := COUNT(GROUP,%Closest%.Diff_phn_fax_2);
    Count_Diff_sud_key_2 := COUNT(GROUP,%Closest%.Diff_sud_key_2);
    Count_Diff_ooc_ind_2 := COUNT(GROUP,%Closest%.Diff_ooc_ind_2);
    Count_Diff_license_nbr_contact := COUNT(GROUP,%Closest%.Diff_license_nbr_contact);
    Count_Diff_name_contact_prefx := COUNT(GROUP,%Closest%.Diff_name_contact_prefx);
    Count_Diff_name_contact_first := COUNT(GROUP,%Closest%.Diff_name_contact_first);
    Count_Diff_name_contact_mid := COUNT(GROUP,%Closest%.Diff_name_contact_mid);
    Count_Diff_name_contact_last := COUNT(GROUP,%Closest%.Diff_name_contact_last);
    Count_Diff_name_contact_sufx := COUNT(GROUP,%Closest%.Diff_name_contact_sufx);
    Count_Diff_name_contact_nick := COUNT(GROUP,%Closest%.Diff_name_contact_nick);
    Count_Diff_name_contact_ttl := COUNT(GROUP,%Closest%.Diff_name_contact_ttl);
    Count_Diff_phn_contact := COUNT(GROUP,%Closest%.Diff_phn_contact);
    Count_Diff_phn_contact_ext := COUNT(GROUP,%Closest%.Diff_phn_contact_ext);
    Count_Diff_phn_contact_fax := COUNT(GROUP,%Closest%.Diff_phn_contact_fax);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_bk_class := COUNT(GROUP,%Closest%.Diff_bk_class);
    Count_Diff_bk_class_desc := COUNT(GROUP,%Closest%.Diff_bk_class_desc);
    Count_Diff_charter := COUNT(GROUP,%Closest%.Diff_charter);
    Count_Diff_inst_beg_dte := COUNT(GROUP,%Closest%.Diff_inst_beg_dte);
    Count_Diff_origin_cd := COUNT(GROUP,%Closest%.Diff_origin_cd);
    Count_Diff_origin_cd_desc := COUNT(GROUP,%Closest%.Diff_origin_cd_desc);
    Count_Diff_disp_type_cd := COUNT(GROUP,%Closest%.Diff_disp_type_cd);
    Count_Diff_disp_type_desc := COUNT(GROUP,%Closest%.Diff_disp_type_desc);
    Count_Diff_reg_agent := COUNT(GROUP,%Closest%.Diff_reg_agent);
    Count_Diff_regulator := COUNT(GROUP,%Closest%.Diff_regulator);
    Count_Diff_hqtr_city := COUNT(GROUP,%Closest%.Diff_hqtr_city);
    Count_Diff_hqtr_name := COUNT(GROUP,%Closest%.Diff_hqtr_name);
    Count_Diff_domestic_off_nbr := COUNT(GROUP,%Closest%.Diff_domestic_off_nbr);
    Count_Diff_foreign_off_nbr := COUNT(GROUP,%Closest%.Diff_foreign_off_nbr);
    Count_Diff_hcr_rssd := COUNT(GROUP,%Closest%.Diff_hcr_rssd);
    Count_Diff_hcr_location := COUNT(GROUP,%Closest%.Diff_hcr_location);
    Count_Diff_affil_type_cd := COUNT(GROUP,%Closest%.Diff_affil_type_cd);
    Count_Diff_genlink := COUNT(GROUP,%Closest%.Diff_genlink);
    Count_Diff_research_ind := COUNT(GROUP,%Closest%.Diff_research_ind);
    Count_Diff_docket_id := COUNT(GROUP,%Closest%.Diff_docket_id);
    Count_Diff_mltreckey := COUNT(GROUP,%Closest%.Diff_mltreckey);
    Count_Diff_cmc_slpk := COUNT(GROUP,%Closest%.Diff_cmc_slpk);
    Count_Diff_pcmc_slpk := COUNT(GROUP,%Closest%.Diff_pcmc_slpk);
    Count_Diff_affil_key := COUNT(GROUP,%Closest%.Diff_affil_key);
    Count_Diff_provnote_1 := COUNT(GROUP,%Closest%.Diff_provnote_1);
    Count_Diff_provnote_2 := COUNT(GROUP,%Closest%.Diff_provnote_2);
    Count_Diff_provnote_3 := COUNT(GROUP,%Closest%.Diff_provnote_3);
    Count_Diff_action_taken_ind := COUNT(GROUP,%Closest%.Diff_action_taken_ind);
    Count_Diff_viol_type := COUNT(GROUP,%Closest%.Diff_viol_type);
    Count_Diff_viol_cd := COUNT(GROUP,%Closest%.Diff_viol_cd);
    Count_Diff_viol_desc := COUNT(GROUP,%Closest%.Diff_viol_desc);
    Count_Diff_viol_dte := COUNT(GROUP,%Closest%.Diff_viol_dte);
    Count_Diff_viol_case_nbr := COUNT(GROUP,%Closest%.Diff_viol_case_nbr);
    Count_Diff_viol_eff_dte := COUNT(GROUP,%Closest%.Diff_viol_eff_dte);
    Count_Diff_action_final_nbr := COUNT(GROUP,%Closest%.Diff_action_final_nbr);
    Count_Diff_action_status := COUNT(GROUP,%Closest%.Diff_action_status);
    Count_Diff_action_status_dte := COUNT(GROUP,%Closest%.Diff_action_status_dte);
    Count_Diff_displinary_action := COUNT(GROUP,%Closest%.Diff_displinary_action);
    Count_Diff_action_file_name := COUNT(GROUP,%Closest%.Diff_action_file_name);
    Count_Diff_occupation := COUNT(GROUP,%Closest%.Diff_occupation);
    Count_Diff_practice_hrs := COUNT(GROUP,%Closest%.Diff_practice_hrs);
    Count_Diff_practice_type := COUNT(GROUP,%Closest%.Diff_practice_type);
    Count_Diff_misc_other_id := COUNT(GROUP,%Closest%.Diff_misc_other_id);
    Count_Diff_misc_other_type := COUNT(GROUP,%Closest%.Diff_misc_other_type);
    Count_Diff_cont_education_ernd := COUNT(GROUP,%Closest%.Diff_cont_education_ernd);
    Count_Diff_cont_education_req := COUNT(GROUP,%Closest%.Diff_cont_education_req);
    Count_Diff_cont_education_term := COUNT(GROUP,%Closest%.Diff_cont_education_term);
    Count_Diff_schl_attend_1 := COUNT(GROUP,%Closest%.Diff_schl_attend_1);
    Count_Diff_schl_attend_dte_1 := COUNT(GROUP,%Closest%.Diff_schl_attend_dte_1);
    Count_Diff_schl_curriculum_1 := COUNT(GROUP,%Closest%.Diff_schl_curriculum_1);
    Count_Diff_schl_degree_1 := COUNT(GROUP,%Closest%.Diff_schl_degree_1);
    Count_Diff_schl_attend_2 := COUNT(GROUP,%Closest%.Diff_schl_attend_2);
    Count_Diff_schl_attend_dte_2 := COUNT(GROUP,%Closest%.Diff_schl_attend_dte_2);
    Count_Diff_schl_curriculum_2 := COUNT(GROUP,%Closest%.Diff_schl_curriculum_2);
    Count_Diff_schl_degree_2 := COUNT(GROUP,%Closest%.Diff_schl_degree_2);
    Count_Diff_schl_attend_3 := COUNT(GROUP,%Closest%.Diff_schl_attend_3);
    Count_Diff_schl_attend_dte_3 := COUNT(GROUP,%Closest%.Diff_schl_attend_dte_3);
    Count_Diff_schl_curriculum_3 := COUNT(GROUP,%Closest%.Diff_schl_curriculum_3);
    Count_Diff_schl_degree_3 := COUNT(GROUP,%Closest%.Diff_schl_degree_3);
    Count_Diff_addl_license_spec := COUNT(GROUP,%Closest%.Diff_addl_license_spec);
    Count_Diff_place_birth_cd := COUNT(GROUP,%Closest%.Diff_place_birth_cd);
    Count_Diff_place_birth_desc := COUNT(GROUP,%Closest%.Diff_place_birth_desc);
    Count_Diff_race_cd := COUNT(GROUP,%Closest%.Diff_race_cd);
    Count_Diff_std_race_cd := COUNT(GROUP,%Closest%.Diff_std_race_cd);
    Count_Diff_race_desc := COUNT(GROUP,%Closest%.Diff_race_desc);
    Count_Diff_status_effect_dte := COUNT(GROUP,%Closest%.Diff_status_effect_dte);
    Count_Diff_status_renew_desc := COUNT(GROUP,%Closest%.Diff_status_renew_desc);
    Count_Diff_agency_status := COUNT(GROUP,%Closest%.Diff_agency_status);
    Count_Diff_prev_primary_key := COUNT(GROUP,%Closest%.Diff_prev_primary_key);
    Count_Diff_prev_mltreckey := COUNT(GROUP,%Closest%.Diff_prev_mltreckey);
    Count_Diff_prev_cmc_slpk := COUNT(GROUP,%Closest%.Diff_prev_cmc_slpk);
    Count_Diff_prev_pcmc_slpk := COUNT(GROUP,%Closest%.Diff_prev_pcmc_slpk);
    Count_Diff_license_id := COUNT(GROUP,%Closest%.Diff_license_id);
    Count_Diff_nmls_id := COUNT(GROUP,%Closest%.Diff_nmls_id);
    Count_Diff_foreign_nmls_id := COUNT(GROUP,%Closest%.Diff_foreign_nmls_id);
    Count_Diff_location_type := COUNT(GROUP,%Closest%.Diff_location_type);
    Count_Diff_off_license_nbr_type := COUNT(GROUP,%Closest%.Diff_off_license_nbr_type);
    Count_Diff_brkr_license_nbr := COUNT(GROUP,%Closest%.Diff_brkr_license_nbr);
    Count_Diff_brkr_license_nbr_type := COUNT(GROUP,%Closest%.Diff_brkr_license_nbr_type);
    Count_Diff_agency_id := COUNT(GROUP,%Closest%.Diff_agency_id);
    Count_Diff_site_location := COUNT(GROUP,%Closest%.Diff_site_location);
    Count_Diff_business_type := COUNT(GROUP,%Closest%.Diff_business_type);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_start_dte := COUNT(GROUP,%Closest%.Diff_start_dte);
    Count_Diff_is_authorized_license := COUNT(GROUP,%Closest%.Diff_is_authorized_license);
    Count_Diff_is_authorized_conduct := COUNT(GROUP,%Closest%.Diff_is_authorized_conduct);
    Count_Diff_federal_regulator := COUNT(GROUP,%Closest%.Diff_federal_regulator);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;