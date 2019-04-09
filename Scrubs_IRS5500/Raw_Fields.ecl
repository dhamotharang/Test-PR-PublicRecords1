IMPORT SALT311;
IMPORT Scrubs_IRS5500; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Fields := MODULE
 
EXPORT NumFields := 124;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_ack_id','invalid_numeric','invalid_pastdate','invalid_generaldate','invalid_type_plan_entity_cd','invalid_type_dfe_plan_entity_cd','invalid_zero_1_bk','invalid_name','invalid_type_pension_bnft_code','invalid_type_welfare_bnft_code','invalid_dfe_mail_us_address','invalid_dfe_mail_foreign_addr','invalid_dfe_loc_us_address','invalid_dfe_loc_foreign_address','invalid_admin_us_address','invalid_admin_foreign_address','invalid_alpha_numeric_blank','invalid_alphablank','invalid_alpha_sp','invalid_state','invalid_full_zip','invalid_phone','invalid_filing_status');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_ack_id' => 1,'invalid_numeric' => 2,'invalid_pastdate' => 3,'invalid_generaldate' => 4,'invalid_type_plan_entity_cd' => 5,'invalid_type_dfe_plan_entity_cd' => 6,'invalid_zero_1_bk' => 7,'invalid_name' => 8,'invalid_type_pension_bnft_code' => 9,'invalid_type_welfare_bnft_code' => 10,'invalid_dfe_mail_us_address' => 11,'invalid_dfe_mail_foreign_addr' => 12,'invalid_dfe_loc_us_address' => 13,'invalid_dfe_loc_foreign_address' => 14,'invalid_admin_us_address' => 15,'invalid_admin_foreign_address' => 16,'invalid_alpha_numeric_blank' => 17,'invalid_alphablank' => 18,'invalid_alpha_sp' => 19,'invalid_state' => 20,'invalid_full_zip' => 21,'invalid_phone' => 22,'invalid_filing_status' => 23,0);
 
EXPORT MakeFT_invalid_ack_id(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789P'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ack_id(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789P'))));
EXPORT InValidMessageFT_invalid_ack_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789P'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.Functions.fn_valid_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_valid_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_plan_entity_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_plan_entity_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','2','3','4','']);
EXPORT InValidMessageFT_invalid_type_plan_entity_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|2|3|4|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_dfe_plan_entity_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_dfe_plan_entity_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','E','G','M','P','']);
EXPORT InValidMessageFT_invalid_type_dfe_plan_entity_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|E|G|M|P|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_1_bk(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_1_bk(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','']);
EXPORT InValidMessageFT_invalid_zero_1_bk(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_names(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_names'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_pension_bnft_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'123ABCDEFGHIJKLMNOPQRST '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_type_pension_bnft_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'123ABCDEFGHIJKLMNOPQRST '))));
EXPORT InValidMessageFT_invalid_type_pension_bnft_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('123ABCDEFGHIJKLMNOPQRST '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_welfare_bnft_code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'4ABCDEFGHIJKLQRSTU '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_type_welfare_bnft_code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'4ABCDEFGHIJKLQRSTU '))));
EXPORT InValidMessageFT_invalid_type_welfare_bnft_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('4ABCDEFGHIJKLQRSTU '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dfe_mail_us_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dfe_mail_us_address(SALT311.StrType s,SALT311.StrType spons_dfe_mail_us_address2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,spons_dfe_mail_us_address2)>0);
EXPORT InValidMessageFT_invalid_dfe_mail_us_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dfe_mail_foreign_addr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dfe_mail_foreign_addr(SALT311.StrType s,SALT311.StrType spons_dfe_mail_foreign_addr2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,spons_dfe_mail_foreign_addr2)>0);
EXPORT InValidMessageFT_invalid_dfe_mail_foreign_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dfe_loc_us_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dfe_loc_us_address(SALT311.StrType s,SALT311.StrType spons_dfe_loc_us_address2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,spons_dfe_loc_us_address2)>0);
EXPORT InValidMessageFT_invalid_dfe_loc_us_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dfe_loc_foreign_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dfe_loc_foreign_address(SALT311.StrType s,SALT311.StrType spons_dfe_loc_foreign_address2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,spons_dfe_loc_foreign_address2)>0);
EXPORT InValidMessageFT_invalid_dfe_loc_foreign_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_admin_us_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_admin_us_address(SALT311.StrType s,SALT311.StrType admin_us_address2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,admin_us_address2)>0);
EXPORT InValidMessageFT_invalid_admin_us_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_admin_foreign_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_admin_foreign_address(SALT311.StrType s,SALT311.StrType admin_foreign_address2) := WHICH(~Scrubs_IRS5500.Functions.fn_chk_blanks(s,admin_foreign_address2)>0);
EXPORT InValidMessageFT_invalid_admin_foreign_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_chk_blanks'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_numeric_blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_numeric_blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_invalid_alpha_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_sp(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-, '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_sp(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ.-, '))));
EXPORT InValidMessageFT_invalid_alpha_sp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ.-, '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_full_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_full_zip(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.functions.fn_verify_full_zip(s)>0);
EXPORT InValidMessageFT_invalid_full_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.functions.fn_verify_full_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_IRS5500.functions.fn_CleanPhone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS5500.functions.fn_CleanPhone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FILING_ERROR','FILING_RECEIVED','PROCESSING_STOPPED','']);
EXPORT InValidMessageFT_invalid_filing_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FILING_ERROR|FILING_RECEIVED|PROCESSING_STOPPED|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ack_id','form_plan_year_begin_date','form_tax_prd','type_plan_entity_cd','type_dfe_plan_entity_cd','initial_filing_ind','amended_ind','final_filing_ind','short_plan_yr_ind','collective_bargain_ind','f5558_application_filed_ind','ext_automatic_ind','dfvc_program_ind','ext_special_ind','ext_special_text','plan_name','spons_dfe_pn','plan_eff_date','sponsor_dfe_name','spons_dfe_dba_name','spons_dfe_care_of_name','spons_dfe_mail_us_address1','spons_dfe_mail_us_address2','spons_dfe_mail_us_city','spons_dfe_mail_us_state','spons_dfe_mail_us_zip','spons_dfe_mail_foreign_addr1','spons_dfe_mail_foreign_addr2','spons_dfe_mail_foreign_city','spons_dfe_mail_forgn_prov_st','spons_dfe_mail_foreign_cntry','spons_dfe_mail_forgn_postal_cd','spons_dfe_loc_us_address1','spons_dfe_loc_us_address2','spons_dfe_loc_us_city','spons_dfe_loc_us_state','spons_dfe_loc_us_zip','spons_dfe_loc_foreign_address1','spons_dfe_loc_foreign_address2','spons_dfe_loc_foreign_city','spons_dfe_loc_forgn_prov_st','spons_dfe_loc_foreign_cntry','spons_dfe_loc_forgn_postal_cd','spons_dfe_ein','spons_dfe_phone_num','business_code','admin_name','admin_care_of_name','admin_us_address1','admin_us_address2','admin_us_city','admin_us_state','admin_us_zip','admin_foreign_address1','admin_foreign_address2','admin_foreign_city','admin_foreign_prov_state','admin_foreign_cntry','admin_foreign_postal_cd','admin_ein','admin_phone_num','last_rpt_spons_name','last_rpt_spons_ein','last_rpt_plan_num','admin_signed_date','admin_signed_name','spons_signed_date','spons_signed_name','dfe_signed_date','dfe_signed_name','tot_partcp_boy_cnt','tot_active_partcp_cnt','rtd_sep_partcp_rcvg_cnt','rtd_sep_partcp_fut_cnt','subtl_act_rtd_sep_cnt','benef_rcvg_bnft_cnt','tot_act_rtd_sep_benef_cnt','partcp_account_bal_cnt','sep_partcp_partl_vstd_cnt','contrib_emplrs_cnt','type_pension_bnft_code','type_welfare_bnft_code','funding_insurance_ind','funding_sec412_ind','funding_trust_ind','funding_gen_asset_ind','benefit_insurance_ind','benefit_sec412_ind','benefit_trust_ind','benefit_gen_asset_ind','sch_r_attached_ind','sch_mb_attached_ind','sch_sb_attached_ind','sch_h_attached_ind','sch_i_attached_ind','sch_a_attached_ind','num_sch_a_attached_cnt','sch_c_attached_ind','sch_d_attached_ind','sch_g_attached_ind','filing_status','date_received','valid_admin_signature','valid_dfe_signature','valid_sponsor_signature','admin_phone_num_foreign','spons_dfe_phone_num_foreign','admin_name_same_spon_ind','admin_address_same_spon_ind','preparer_name','preparer_firm_name','preparer_us_address1','preparer_us_address2','preparer_us_city','preparer_us_state','preparer_us_zip','preparer_foreign_address1','preparer_foreign_address2','preparer_foreign_city','preparer_foreign_prov_state','preparer_foreign_cntry','preparer_foreign_postal_cd','preparer_phone_num','preparer_phone_num_foreign');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ack_id','form_plan_year_begin_date','form_tax_prd','type_plan_entity_cd','type_dfe_plan_entity_cd','initial_filing_ind','amended_ind','final_filing_ind','short_plan_yr_ind','collective_bargain_ind','f5558_application_filed_ind','ext_automatic_ind','dfvc_program_ind','ext_special_ind','ext_special_text','plan_name','spons_dfe_pn','plan_eff_date','sponsor_dfe_name','spons_dfe_dba_name','spons_dfe_care_of_name','spons_dfe_mail_us_address1','spons_dfe_mail_us_address2','spons_dfe_mail_us_city','spons_dfe_mail_us_state','spons_dfe_mail_us_zip','spons_dfe_mail_foreign_addr1','spons_dfe_mail_foreign_addr2','spons_dfe_mail_foreign_city','spons_dfe_mail_forgn_prov_st','spons_dfe_mail_foreign_cntry','spons_dfe_mail_forgn_postal_cd','spons_dfe_loc_us_address1','spons_dfe_loc_us_address2','spons_dfe_loc_us_city','spons_dfe_loc_us_state','spons_dfe_loc_us_zip','spons_dfe_loc_foreign_address1','spons_dfe_loc_foreign_address2','spons_dfe_loc_foreign_city','spons_dfe_loc_forgn_prov_st','spons_dfe_loc_foreign_cntry','spons_dfe_loc_forgn_postal_cd','spons_dfe_ein','spons_dfe_phone_num','business_code','admin_name','admin_care_of_name','admin_us_address1','admin_us_address2','admin_us_city','admin_us_state','admin_us_zip','admin_foreign_address1','admin_foreign_address2','admin_foreign_city','admin_foreign_prov_state','admin_foreign_cntry','admin_foreign_postal_cd','admin_ein','admin_phone_num','last_rpt_spons_name','last_rpt_spons_ein','last_rpt_plan_num','admin_signed_date','admin_signed_name','spons_signed_date','spons_signed_name','dfe_signed_date','dfe_signed_name','tot_partcp_boy_cnt','tot_active_partcp_cnt','rtd_sep_partcp_rcvg_cnt','rtd_sep_partcp_fut_cnt','subtl_act_rtd_sep_cnt','benef_rcvg_bnft_cnt','tot_act_rtd_sep_benef_cnt','partcp_account_bal_cnt','sep_partcp_partl_vstd_cnt','contrib_emplrs_cnt','type_pension_bnft_code','type_welfare_bnft_code','funding_insurance_ind','funding_sec412_ind','funding_trust_ind','funding_gen_asset_ind','benefit_insurance_ind','benefit_sec412_ind','benefit_trust_ind','benefit_gen_asset_ind','sch_r_attached_ind','sch_mb_attached_ind','sch_sb_attached_ind','sch_h_attached_ind','sch_i_attached_ind','sch_a_attached_ind','num_sch_a_attached_cnt','sch_c_attached_ind','sch_d_attached_ind','sch_g_attached_ind','filing_status','date_received','valid_admin_signature','valid_dfe_signature','valid_sponsor_signature','admin_phone_num_foreign','spons_dfe_phone_num_foreign','admin_name_same_spon_ind','admin_address_same_spon_ind','preparer_name','preparer_firm_name','preparer_us_address1','preparer_us_address2','preparer_us_city','preparer_us_state','preparer_us_zip','preparer_foreign_address1','preparer_foreign_address2','preparer_foreign_city','preparer_foreign_prov_state','preparer_foreign_cntry','preparer_foreign_postal_cd','preparer_phone_num','preparer_phone_num_foreign');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ack_id' => 0,'form_plan_year_begin_date' => 1,'form_tax_prd' => 2,'type_plan_entity_cd' => 3,'type_dfe_plan_entity_cd' => 4,'initial_filing_ind' => 5,'amended_ind' => 6,'final_filing_ind' => 7,'short_plan_yr_ind' => 8,'collective_bargain_ind' => 9,'f5558_application_filed_ind' => 10,'ext_automatic_ind' => 11,'dfvc_program_ind' => 12,'ext_special_ind' => 13,'ext_special_text' => 14,'plan_name' => 15,'spons_dfe_pn' => 16,'plan_eff_date' => 17,'sponsor_dfe_name' => 18,'spons_dfe_dba_name' => 19,'spons_dfe_care_of_name' => 20,'spons_dfe_mail_us_address1' => 21,'spons_dfe_mail_us_address2' => 22,'spons_dfe_mail_us_city' => 23,'spons_dfe_mail_us_state' => 24,'spons_dfe_mail_us_zip' => 25,'spons_dfe_mail_foreign_addr1' => 26,'spons_dfe_mail_foreign_addr2' => 27,'spons_dfe_mail_foreign_city' => 28,'spons_dfe_mail_forgn_prov_st' => 29,'spons_dfe_mail_foreign_cntry' => 30,'spons_dfe_mail_forgn_postal_cd' => 31,'spons_dfe_loc_us_address1' => 32,'spons_dfe_loc_us_address2' => 33,'spons_dfe_loc_us_city' => 34,'spons_dfe_loc_us_state' => 35,'spons_dfe_loc_us_zip' => 36,'spons_dfe_loc_foreign_address1' => 37,'spons_dfe_loc_foreign_address2' => 38,'spons_dfe_loc_foreign_city' => 39,'spons_dfe_loc_forgn_prov_st' => 40,'spons_dfe_loc_foreign_cntry' => 41,'spons_dfe_loc_forgn_postal_cd' => 42,'spons_dfe_ein' => 43,'spons_dfe_phone_num' => 44,'business_code' => 45,'admin_name' => 46,'admin_care_of_name' => 47,'admin_us_address1' => 48,'admin_us_address2' => 49,'admin_us_city' => 50,'admin_us_state' => 51,'admin_us_zip' => 52,'admin_foreign_address1' => 53,'admin_foreign_address2' => 54,'admin_foreign_city' => 55,'admin_foreign_prov_state' => 56,'admin_foreign_cntry' => 57,'admin_foreign_postal_cd' => 58,'admin_ein' => 59,'admin_phone_num' => 60,'last_rpt_spons_name' => 61,'last_rpt_spons_ein' => 62,'last_rpt_plan_num' => 63,'admin_signed_date' => 64,'admin_signed_name' => 65,'spons_signed_date' => 66,'spons_signed_name' => 67,'dfe_signed_date' => 68,'dfe_signed_name' => 69,'tot_partcp_boy_cnt' => 70,'tot_active_partcp_cnt' => 71,'rtd_sep_partcp_rcvg_cnt' => 72,'rtd_sep_partcp_fut_cnt' => 73,'subtl_act_rtd_sep_cnt' => 74,'benef_rcvg_bnft_cnt' => 75,'tot_act_rtd_sep_benef_cnt' => 76,'partcp_account_bal_cnt' => 77,'sep_partcp_partl_vstd_cnt' => 78,'contrib_emplrs_cnt' => 79,'type_pension_bnft_code' => 80,'type_welfare_bnft_code' => 81,'funding_insurance_ind' => 82,'funding_sec412_ind' => 83,'funding_trust_ind' => 84,'funding_gen_asset_ind' => 85,'benefit_insurance_ind' => 86,'benefit_sec412_ind' => 87,'benefit_trust_ind' => 88,'benefit_gen_asset_ind' => 89,'sch_r_attached_ind' => 90,'sch_mb_attached_ind' => 91,'sch_sb_attached_ind' => 92,'sch_h_attached_ind' => 93,'sch_i_attached_ind' => 94,'sch_a_attached_ind' => 95,'num_sch_a_attached_cnt' => 96,'sch_c_attached_ind' => 97,'sch_d_attached_ind' => 98,'sch_g_attached_ind' => 99,'filing_status' => 100,'date_received' => 101,'valid_admin_signature' => 102,'valid_dfe_signature' => 103,'valid_sponsor_signature' => 104,'admin_phone_num_foreign' => 105,'spons_dfe_phone_num_foreign' => 106,'admin_name_same_spon_ind' => 107,'admin_address_same_spon_ind' => 108,'preparer_name' => 109,'preparer_firm_name' => 110,'preparer_us_address1' => 111,'preparer_us_address2' => 112,'preparer_us_city' => 113,'preparer_us_state' => 114,'preparer_us_zip' => 115,'preparer_foreign_address1' => 116,'preparer_foreign_address2' => 117,'preparer_foreign_city' => 118,'preparer_foreign_prov_state' => 119,'preparer_foreign_cntry' => 120,'preparer_foreign_postal_cd' => 121,'preparer_phone_num' => 122,'preparer_phone_num_foreign' => 123,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],[],[],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ack_id(SALT311.StrType s0) := MakeFT_invalid_ack_id(s0);
EXPORT InValid_ack_id(SALT311.StrType s) := InValidFT_invalid_ack_id(s);
EXPORT InValidMessage_ack_id(UNSIGNED1 wh) := InValidMessageFT_invalid_ack_id(wh);
 
EXPORT Make_form_plan_year_begin_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_form_plan_year_begin_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_form_plan_year_begin_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_form_tax_prd(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_form_tax_prd(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_form_tax_prd(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_type_plan_entity_cd(SALT311.StrType s0) := MakeFT_invalid_type_plan_entity_cd(s0);
EXPORT InValid_type_plan_entity_cd(SALT311.StrType s) := InValidFT_invalid_type_plan_entity_cd(s);
EXPORT InValidMessage_type_plan_entity_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_type_plan_entity_cd(wh);
 
EXPORT Make_type_dfe_plan_entity_cd(SALT311.StrType s0) := MakeFT_invalid_type_dfe_plan_entity_cd(s0);
EXPORT InValid_type_dfe_plan_entity_cd(SALT311.StrType s) := InValidFT_invalid_type_dfe_plan_entity_cd(s);
EXPORT InValidMessage_type_dfe_plan_entity_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_type_dfe_plan_entity_cd(wh);
 
EXPORT Make_initial_filing_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_initial_filing_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_initial_filing_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_amended_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_amended_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_amended_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_final_filing_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_final_filing_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_final_filing_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_short_plan_yr_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_short_plan_yr_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_short_plan_yr_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_collective_bargain_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_collective_bargain_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_collective_bargain_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_f5558_application_filed_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_f5558_application_filed_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_f5558_application_filed_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_ext_automatic_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_ext_automatic_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_ext_automatic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_dfvc_program_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_dfvc_program_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_dfvc_program_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_ext_special_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_ext_special_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_ext_special_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_ext_special_text(SALT311.StrType s0) := s0;
EXPORT InValid_ext_special_text(SALT311.StrType s) := 0;
EXPORT InValidMessage_ext_special_text(UNSIGNED1 wh) := '';
 
EXPORT Make_plan_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_plan_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_plan_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_spons_dfe_pn(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_spons_dfe_pn(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_spons_dfe_pn(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_plan_eff_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_plan_eff_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_plan_eff_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_sponsor_dfe_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_sponsor_dfe_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_sponsor_dfe_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_spons_dfe_dba_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_spons_dfe_dba_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_spons_dfe_dba_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_spons_dfe_care_of_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_spons_dfe_care_of_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_spons_dfe_care_of_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_spons_dfe_mail_us_address1(SALT311.StrType s0) := MakeFT_invalid_dfe_mail_us_address(s0);
EXPORT InValid_spons_dfe_mail_us_address1(SALT311.StrType s,SALT311.StrType spons_dfe_mail_us_address2) := InValidFT_invalid_dfe_mail_us_address(s,spons_dfe_mail_us_address2);
EXPORT InValidMessage_spons_dfe_mail_us_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_dfe_mail_us_address(wh);
 
EXPORT Make_spons_dfe_mail_us_address2(SALT311.StrType s0) := s0;
EXPORT InValid_spons_dfe_mail_us_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_spons_dfe_mail_us_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_spons_dfe_mail_us_city(SALT311.StrType s0) := MakeFT_invalid_alpha_sp(s0);
EXPORT InValid_spons_dfe_mail_us_city(SALT311.StrType s) := InValidFT_invalid_alpha_sp(s);
EXPORT InValidMessage_spons_dfe_mail_us_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_sp(wh);
 
EXPORT Make_spons_dfe_mail_us_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_spons_dfe_mail_us_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_spons_dfe_mail_us_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_spons_dfe_mail_us_zip(SALT311.StrType s0) := MakeFT_invalid_full_zip(s0);
EXPORT InValid_spons_dfe_mail_us_zip(SALT311.StrType s) := InValidFT_invalid_full_zip(s);
EXPORT InValidMessage_spons_dfe_mail_us_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_full_zip(wh);
 
EXPORT Make_spons_dfe_mail_foreign_addr1(SALT311.StrType s0) := MakeFT_invalid_dfe_mail_foreign_addr(s0);
EXPORT InValid_spons_dfe_mail_foreign_addr1(SALT311.StrType s,SALT311.StrType spons_dfe_mail_foreign_addr2) := InValidFT_invalid_dfe_mail_foreign_addr(s,spons_dfe_mail_foreign_addr2);
EXPORT InValidMessage_spons_dfe_mail_foreign_addr1(UNSIGNED1 wh) := InValidMessageFT_invalid_dfe_mail_foreign_addr(wh);
 
EXPORT Make_spons_dfe_mail_foreign_addr2(SALT311.StrType s0) := s0;
EXPORT InValid_spons_dfe_mail_foreign_addr2(SALT311.StrType s) := 0;
EXPORT InValidMessage_spons_dfe_mail_foreign_addr2(UNSIGNED1 wh) := '';
 
EXPORT Make_spons_dfe_mail_foreign_city(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_mail_foreign_city(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_mail_foreign_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_mail_forgn_prov_st(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_mail_forgn_prov_st(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_mail_forgn_prov_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_mail_foreign_cntry(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_mail_foreign_cntry(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_mail_foreign_cntry(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_mail_forgn_postal_cd(SALT311.StrType s0) := MakeFT_invalid_alpha_numeric_blank(s0);
EXPORT InValid_spons_dfe_mail_forgn_postal_cd(SALT311.StrType s) := InValidFT_invalid_alpha_numeric_blank(s);
EXPORT InValidMessage_spons_dfe_mail_forgn_postal_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric_blank(wh);
 
EXPORT Make_spons_dfe_loc_us_address1(SALT311.StrType s0) := MakeFT_invalid_dfe_loc_us_address(s0);
EXPORT InValid_spons_dfe_loc_us_address1(SALT311.StrType s,SALT311.StrType spons_dfe_loc_us_address2) := InValidFT_invalid_dfe_loc_us_address(s,spons_dfe_loc_us_address2);
EXPORT InValidMessage_spons_dfe_loc_us_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_dfe_loc_us_address(wh);
 
EXPORT Make_spons_dfe_loc_us_address2(SALT311.StrType s0) := s0;
EXPORT InValid_spons_dfe_loc_us_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_spons_dfe_loc_us_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_spons_dfe_loc_us_city(SALT311.StrType s0) := MakeFT_invalid_alpha_sp(s0);
EXPORT InValid_spons_dfe_loc_us_city(SALT311.StrType s) := InValidFT_invalid_alpha_sp(s);
EXPORT InValidMessage_spons_dfe_loc_us_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_sp(wh);
 
EXPORT Make_spons_dfe_loc_us_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_spons_dfe_loc_us_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_spons_dfe_loc_us_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_spons_dfe_loc_us_zip(SALT311.StrType s0) := MakeFT_invalid_full_zip(s0);
EXPORT InValid_spons_dfe_loc_us_zip(SALT311.StrType s) := InValidFT_invalid_full_zip(s);
EXPORT InValidMessage_spons_dfe_loc_us_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_full_zip(wh);
 
EXPORT Make_spons_dfe_loc_foreign_address1(SALT311.StrType s0) := MakeFT_invalid_dfe_loc_foreign_address(s0);
EXPORT InValid_spons_dfe_loc_foreign_address1(SALT311.StrType s,SALT311.StrType spons_dfe_loc_foreign_address2) := InValidFT_invalid_dfe_loc_foreign_address(s,spons_dfe_loc_foreign_address2);
EXPORT InValidMessage_spons_dfe_loc_foreign_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_dfe_loc_foreign_address(wh);
 
EXPORT Make_spons_dfe_loc_foreign_address2(SALT311.StrType s0) := s0;
EXPORT InValid_spons_dfe_loc_foreign_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_spons_dfe_loc_foreign_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_spons_dfe_loc_foreign_city(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_loc_foreign_city(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_loc_foreign_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_loc_forgn_prov_st(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_loc_forgn_prov_st(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_loc_forgn_prov_st(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_loc_foreign_cntry(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_spons_dfe_loc_foreign_cntry(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_spons_dfe_loc_foreign_cntry(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_spons_dfe_loc_forgn_postal_cd(SALT311.StrType s0) := MakeFT_invalid_alpha_numeric_blank(s0);
EXPORT InValid_spons_dfe_loc_forgn_postal_cd(SALT311.StrType s) := InValidFT_invalid_alpha_numeric_blank(s);
EXPORT InValidMessage_spons_dfe_loc_forgn_postal_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric_blank(wh);
 
EXPORT Make_spons_dfe_ein(SALT311.StrType s0) := s0;
EXPORT InValid_spons_dfe_ein(SALT311.StrType s) := 0;
EXPORT InValidMessage_spons_dfe_ein(UNSIGNED1 wh) := '';
 
EXPORT Make_spons_dfe_phone_num(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_spons_dfe_phone_num(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_spons_dfe_phone_num(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_business_code(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_business_code(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_business_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_admin_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_admin_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_admin_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_admin_care_of_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_admin_care_of_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_admin_care_of_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_admin_us_address1(SALT311.StrType s0) := MakeFT_invalid_admin_us_address(s0);
EXPORT InValid_admin_us_address1(SALT311.StrType s,SALT311.StrType admin_us_address2) := InValidFT_invalid_admin_us_address(s,admin_us_address2);
EXPORT InValidMessage_admin_us_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_admin_us_address(wh);
 
EXPORT Make_admin_us_address2(SALT311.StrType s0) := s0;
EXPORT InValid_admin_us_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_admin_us_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_admin_us_city(SALT311.StrType s0) := MakeFT_invalid_alpha_sp(s0);
EXPORT InValid_admin_us_city(SALT311.StrType s) := InValidFT_invalid_alpha_sp(s);
EXPORT InValidMessage_admin_us_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_sp(wh);
 
EXPORT Make_admin_us_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_admin_us_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_admin_us_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_admin_us_zip(SALT311.StrType s0) := MakeFT_invalid_full_zip(s0);
EXPORT InValid_admin_us_zip(SALT311.StrType s) := InValidFT_invalid_full_zip(s);
EXPORT InValidMessage_admin_us_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_full_zip(wh);
 
EXPORT Make_admin_foreign_address1(SALT311.StrType s0) := MakeFT_invalid_admin_foreign_address(s0);
EXPORT InValid_admin_foreign_address1(SALT311.StrType s,SALT311.StrType admin_foreign_address2) := InValidFT_invalid_admin_foreign_address(s,admin_foreign_address2);
EXPORT InValidMessage_admin_foreign_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_admin_foreign_address(wh);
 
EXPORT Make_admin_foreign_address2(SALT311.StrType s0) := s0;
EXPORT InValid_admin_foreign_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_admin_foreign_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_admin_foreign_city(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_admin_foreign_city(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_admin_foreign_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_admin_foreign_prov_state(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_admin_foreign_prov_state(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_admin_foreign_prov_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_admin_foreign_cntry(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_admin_foreign_cntry(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_admin_foreign_cntry(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_admin_foreign_postal_cd(SALT311.StrType s0) := MakeFT_invalid_alpha_numeric_blank(s0);
EXPORT InValid_admin_foreign_postal_cd(SALT311.StrType s) := InValidFT_invalid_alpha_numeric_blank(s);
EXPORT InValidMessage_admin_foreign_postal_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric_blank(wh);
 
EXPORT Make_admin_ein(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_admin_ein(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_admin_ein(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_admin_phone_num(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_admin_phone_num(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_admin_phone_num(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_last_rpt_spons_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_last_rpt_spons_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_last_rpt_spons_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_last_rpt_spons_ein(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_last_rpt_spons_ein(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_last_rpt_spons_ein(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_last_rpt_plan_num(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_last_rpt_plan_num(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_last_rpt_plan_num(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_admin_signed_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_admin_signed_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_admin_signed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_admin_signed_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_admin_signed_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_admin_signed_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_spons_signed_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_spons_signed_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_spons_signed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_spons_signed_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_spons_signed_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_spons_signed_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_dfe_signed_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dfe_signed_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dfe_signed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dfe_signed_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_dfe_signed_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_dfe_signed_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_tot_partcp_boy_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_tot_partcp_boy_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_tot_partcp_boy_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_tot_active_partcp_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_tot_active_partcp_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_tot_active_partcp_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_rtd_sep_partcp_rcvg_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rtd_sep_partcp_rcvg_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rtd_sep_partcp_rcvg_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_rtd_sep_partcp_fut_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rtd_sep_partcp_fut_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rtd_sep_partcp_fut_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_subtl_act_rtd_sep_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_subtl_act_rtd_sep_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_subtl_act_rtd_sep_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_benef_rcvg_bnft_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_benef_rcvg_bnft_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_benef_rcvg_bnft_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_tot_act_rtd_sep_benef_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_tot_act_rtd_sep_benef_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_tot_act_rtd_sep_benef_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_partcp_account_bal_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_partcp_account_bal_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_partcp_account_bal_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_sep_partcp_partl_vstd_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_sep_partcp_partl_vstd_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_sep_partcp_partl_vstd_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_contrib_emplrs_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_contrib_emplrs_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_contrib_emplrs_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_type_pension_bnft_code(SALT311.StrType s0) := MakeFT_invalid_type_pension_bnft_code(s0);
EXPORT InValid_type_pension_bnft_code(SALT311.StrType s) := InValidFT_invalid_type_pension_bnft_code(s);
EXPORT InValidMessage_type_pension_bnft_code(UNSIGNED1 wh) := InValidMessageFT_invalid_type_pension_bnft_code(wh);
 
EXPORT Make_type_welfare_bnft_code(SALT311.StrType s0) := MakeFT_invalid_type_welfare_bnft_code(s0);
EXPORT InValid_type_welfare_bnft_code(SALT311.StrType s) := InValidFT_invalid_type_welfare_bnft_code(s);
EXPORT InValidMessage_type_welfare_bnft_code(UNSIGNED1 wh) := InValidMessageFT_invalid_type_welfare_bnft_code(wh);
 
EXPORT Make_funding_insurance_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_funding_insurance_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_funding_insurance_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_funding_sec412_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_funding_sec412_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_funding_sec412_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_funding_trust_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_funding_trust_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_funding_trust_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_funding_gen_asset_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_funding_gen_asset_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_funding_gen_asset_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_benefit_insurance_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_benefit_insurance_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_benefit_insurance_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_benefit_sec412_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_benefit_sec412_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_benefit_sec412_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_benefit_trust_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_benefit_trust_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_benefit_trust_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_benefit_gen_asset_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_benefit_gen_asset_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_benefit_gen_asset_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_r_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_r_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_r_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_mb_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_mb_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_mb_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_sb_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_sb_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_sb_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_h_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_h_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_h_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_i_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_i_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_i_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_a_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_a_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_a_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_num_sch_a_attached_cnt(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_num_sch_a_attached_cnt(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_num_sch_a_attached_cnt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_sch_c_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_c_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_c_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_d_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_d_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_d_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_sch_g_attached_ind(SALT311.StrType s0) := MakeFT_invalid_zero_1_bk(s0);
EXPORT InValid_sch_g_attached_ind(SALT311.StrType s) := InValidFT_invalid_zero_1_bk(s);
EXPORT InValidMessage_sch_g_attached_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_1_bk(wh);
 
EXPORT Make_filing_status(SALT311.StrType s0) := MakeFT_invalid_filing_status(s0);
EXPORT InValid_filing_status(SALT311.StrType s) := InValidFT_invalid_filing_status(s);
EXPORT InValidMessage_filing_status(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_status(wh);
 
EXPORT Make_date_received(SALT311.StrType s0) := MakeFT_invalid_generaldate(s0);
EXPORT InValid_date_received(SALT311.StrType s) := InValidFT_invalid_generaldate(s);
EXPORT InValidMessage_date_received(UNSIGNED1 wh) := InValidMessageFT_invalid_generaldate(wh);
 
EXPORT Make_valid_admin_signature(SALT311.StrType s0) := s0;
EXPORT InValid_valid_admin_signature(SALT311.StrType s) := 0;
EXPORT InValidMessage_valid_admin_signature(UNSIGNED1 wh) := '';
 
EXPORT Make_valid_dfe_signature(SALT311.StrType s0) := s0;
EXPORT InValid_valid_dfe_signature(SALT311.StrType s) := 0;
EXPORT InValidMessage_valid_dfe_signature(UNSIGNED1 wh) := '';
 
EXPORT Make_valid_sponsor_signature(SALT311.StrType s0) := s0;
EXPORT InValid_valid_sponsor_signature(SALT311.StrType s) := 0;
EXPORT InValidMessage_valid_sponsor_signature(UNSIGNED1 wh) := '';
 
EXPORT Make_admin_phone_num_foreign(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_admin_phone_num_foreign(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_admin_phone_num_foreign(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_spons_dfe_phone_num_foreign(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_spons_dfe_phone_num_foreign(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_spons_dfe_phone_num_foreign(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_admin_name_same_spon_ind(SALT311.StrType s0) := s0;
EXPORT InValid_admin_name_same_spon_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_admin_name_same_spon_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_admin_address_same_spon_ind(SALT311.StrType s0) := s0;
EXPORT InValid_admin_address_same_spon_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_admin_address_same_spon_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_name(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_name(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_firm_name(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_firm_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_firm_name(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_us_address1(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_us_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_us_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_us_address2(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_us_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_us_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_us_city(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_us_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_us_city(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_us_state(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_us_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_us_state(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_us_zip(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_us_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_us_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_address1(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_address2(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_city(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_city(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_prov_state(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_prov_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_prov_state(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_cntry(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_cntry(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_cntry(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_foreign_postal_cd(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_foreign_postal_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_foreign_postal_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_phone_num(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_phone_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_phone_num(UNSIGNED1 wh) := '';
 
EXPORT Make_preparer_phone_num_foreign(SALT311.StrType s0) := s0;
EXPORT InValid_preparer_phone_num_foreign(SALT311.StrType s) := 0;
EXPORT InValidMessage_preparer_phone_num_foreign(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_IRS5500;
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
    BOOLEAN Diff_ack_id;
    BOOLEAN Diff_form_plan_year_begin_date;
    BOOLEAN Diff_form_tax_prd;
    BOOLEAN Diff_type_plan_entity_cd;
    BOOLEAN Diff_type_dfe_plan_entity_cd;
    BOOLEAN Diff_initial_filing_ind;
    BOOLEAN Diff_amended_ind;
    BOOLEAN Diff_final_filing_ind;
    BOOLEAN Diff_short_plan_yr_ind;
    BOOLEAN Diff_collective_bargain_ind;
    BOOLEAN Diff_f5558_application_filed_ind;
    BOOLEAN Diff_ext_automatic_ind;
    BOOLEAN Diff_dfvc_program_ind;
    BOOLEAN Diff_ext_special_ind;
    BOOLEAN Diff_ext_special_text;
    BOOLEAN Diff_plan_name;
    BOOLEAN Diff_spons_dfe_pn;
    BOOLEAN Diff_plan_eff_date;
    BOOLEAN Diff_sponsor_dfe_name;
    BOOLEAN Diff_spons_dfe_dba_name;
    BOOLEAN Diff_spons_dfe_care_of_name;
    BOOLEAN Diff_spons_dfe_mail_us_address1;
    BOOLEAN Diff_spons_dfe_mail_us_address2;
    BOOLEAN Diff_spons_dfe_mail_us_city;
    BOOLEAN Diff_spons_dfe_mail_us_state;
    BOOLEAN Diff_spons_dfe_mail_us_zip;
    BOOLEAN Diff_spons_dfe_mail_foreign_addr1;
    BOOLEAN Diff_spons_dfe_mail_foreign_addr2;
    BOOLEAN Diff_spons_dfe_mail_foreign_city;
    BOOLEAN Diff_spons_dfe_mail_forgn_prov_st;
    BOOLEAN Diff_spons_dfe_mail_foreign_cntry;
    BOOLEAN Diff_spons_dfe_mail_forgn_postal_cd;
    BOOLEAN Diff_spons_dfe_loc_us_address1;
    BOOLEAN Diff_spons_dfe_loc_us_address2;
    BOOLEAN Diff_spons_dfe_loc_us_city;
    BOOLEAN Diff_spons_dfe_loc_us_state;
    BOOLEAN Diff_spons_dfe_loc_us_zip;
    BOOLEAN Diff_spons_dfe_loc_foreign_address1;
    BOOLEAN Diff_spons_dfe_loc_foreign_address2;
    BOOLEAN Diff_spons_dfe_loc_foreign_city;
    BOOLEAN Diff_spons_dfe_loc_forgn_prov_st;
    BOOLEAN Diff_spons_dfe_loc_foreign_cntry;
    BOOLEAN Diff_spons_dfe_loc_forgn_postal_cd;
    BOOLEAN Diff_spons_dfe_ein;
    BOOLEAN Diff_spons_dfe_phone_num;
    BOOLEAN Diff_business_code;
    BOOLEAN Diff_admin_name;
    BOOLEAN Diff_admin_care_of_name;
    BOOLEAN Diff_admin_us_address1;
    BOOLEAN Diff_admin_us_address2;
    BOOLEAN Diff_admin_us_city;
    BOOLEAN Diff_admin_us_state;
    BOOLEAN Diff_admin_us_zip;
    BOOLEAN Diff_admin_foreign_address1;
    BOOLEAN Diff_admin_foreign_address2;
    BOOLEAN Diff_admin_foreign_city;
    BOOLEAN Diff_admin_foreign_prov_state;
    BOOLEAN Diff_admin_foreign_cntry;
    BOOLEAN Diff_admin_foreign_postal_cd;
    BOOLEAN Diff_admin_ein;
    BOOLEAN Diff_admin_phone_num;
    BOOLEAN Diff_last_rpt_spons_name;
    BOOLEAN Diff_last_rpt_spons_ein;
    BOOLEAN Diff_last_rpt_plan_num;
    BOOLEAN Diff_admin_signed_date;
    BOOLEAN Diff_admin_signed_name;
    BOOLEAN Diff_spons_signed_date;
    BOOLEAN Diff_spons_signed_name;
    BOOLEAN Diff_dfe_signed_date;
    BOOLEAN Diff_dfe_signed_name;
    BOOLEAN Diff_tot_partcp_boy_cnt;
    BOOLEAN Diff_tot_active_partcp_cnt;
    BOOLEAN Diff_rtd_sep_partcp_rcvg_cnt;
    BOOLEAN Diff_rtd_sep_partcp_fut_cnt;
    BOOLEAN Diff_subtl_act_rtd_sep_cnt;
    BOOLEAN Diff_benef_rcvg_bnft_cnt;
    BOOLEAN Diff_tot_act_rtd_sep_benef_cnt;
    BOOLEAN Diff_partcp_account_bal_cnt;
    BOOLEAN Diff_sep_partcp_partl_vstd_cnt;
    BOOLEAN Diff_contrib_emplrs_cnt;
    BOOLEAN Diff_type_pension_bnft_code;
    BOOLEAN Diff_type_welfare_bnft_code;
    BOOLEAN Diff_funding_insurance_ind;
    BOOLEAN Diff_funding_sec412_ind;
    BOOLEAN Diff_funding_trust_ind;
    BOOLEAN Diff_funding_gen_asset_ind;
    BOOLEAN Diff_benefit_insurance_ind;
    BOOLEAN Diff_benefit_sec412_ind;
    BOOLEAN Diff_benefit_trust_ind;
    BOOLEAN Diff_benefit_gen_asset_ind;
    BOOLEAN Diff_sch_r_attached_ind;
    BOOLEAN Diff_sch_mb_attached_ind;
    BOOLEAN Diff_sch_sb_attached_ind;
    BOOLEAN Diff_sch_h_attached_ind;
    BOOLEAN Diff_sch_i_attached_ind;
    BOOLEAN Diff_sch_a_attached_ind;
    BOOLEAN Diff_num_sch_a_attached_cnt;
    BOOLEAN Diff_sch_c_attached_ind;
    BOOLEAN Diff_sch_d_attached_ind;
    BOOLEAN Diff_sch_g_attached_ind;
    BOOLEAN Diff_filing_status;
    BOOLEAN Diff_date_received;
    BOOLEAN Diff_valid_admin_signature;
    BOOLEAN Diff_valid_dfe_signature;
    BOOLEAN Diff_valid_sponsor_signature;
    BOOLEAN Diff_admin_phone_num_foreign;
    BOOLEAN Diff_spons_dfe_phone_num_foreign;
    BOOLEAN Diff_admin_name_same_spon_ind;
    BOOLEAN Diff_admin_address_same_spon_ind;
    BOOLEAN Diff_preparer_name;
    BOOLEAN Diff_preparer_firm_name;
    BOOLEAN Diff_preparer_us_address1;
    BOOLEAN Diff_preparer_us_address2;
    BOOLEAN Diff_preparer_us_city;
    BOOLEAN Diff_preparer_us_state;
    BOOLEAN Diff_preparer_us_zip;
    BOOLEAN Diff_preparer_foreign_address1;
    BOOLEAN Diff_preparer_foreign_address2;
    BOOLEAN Diff_preparer_foreign_city;
    BOOLEAN Diff_preparer_foreign_prov_state;
    BOOLEAN Diff_preparer_foreign_cntry;
    BOOLEAN Diff_preparer_foreign_postal_cd;
    BOOLEAN Diff_preparer_phone_num;
    BOOLEAN Diff_preparer_phone_num_foreign;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ack_id := le.ack_id <> ri.ack_id;
    SELF.Diff_form_plan_year_begin_date := le.form_plan_year_begin_date <> ri.form_plan_year_begin_date;
    SELF.Diff_form_tax_prd := le.form_tax_prd <> ri.form_tax_prd;
    SELF.Diff_type_plan_entity_cd := le.type_plan_entity_cd <> ri.type_plan_entity_cd;
    SELF.Diff_type_dfe_plan_entity_cd := le.type_dfe_plan_entity_cd <> ri.type_dfe_plan_entity_cd;
    SELF.Diff_initial_filing_ind := le.initial_filing_ind <> ri.initial_filing_ind;
    SELF.Diff_amended_ind := le.amended_ind <> ri.amended_ind;
    SELF.Diff_final_filing_ind := le.final_filing_ind <> ri.final_filing_ind;
    SELF.Diff_short_plan_yr_ind := le.short_plan_yr_ind <> ri.short_plan_yr_ind;
    SELF.Diff_collective_bargain_ind := le.collective_bargain_ind <> ri.collective_bargain_ind;
    SELF.Diff_f5558_application_filed_ind := le.f5558_application_filed_ind <> ri.f5558_application_filed_ind;
    SELF.Diff_ext_automatic_ind := le.ext_automatic_ind <> ri.ext_automatic_ind;
    SELF.Diff_dfvc_program_ind := le.dfvc_program_ind <> ri.dfvc_program_ind;
    SELF.Diff_ext_special_ind := le.ext_special_ind <> ri.ext_special_ind;
    SELF.Diff_ext_special_text := le.ext_special_text <> ri.ext_special_text;
    SELF.Diff_plan_name := le.plan_name <> ri.plan_name;
    SELF.Diff_spons_dfe_pn := le.spons_dfe_pn <> ri.spons_dfe_pn;
    SELF.Diff_plan_eff_date := le.plan_eff_date <> ri.plan_eff_date;
    SELF.Diff_sponsor_dfe_name := le.sponsor_dfe_name <> ri.sponsor_dfe_name;
    SELF.Diff_spons_dfe_dba_name := le.spons_dfe_dba_name <> ri.spons_dfe_dba_name;
    SELF.Diff_spons_dfe_care_of_name := le.spons_dfe_care_of_name <> ri.spons_dfe_care_of_name;
    SELF.Diff_spons_dfe_mail_us_address1 := le.spons_dfe_mail_us_address1 <> ri.spons_dfe_mail_us_address1;
    SELF.Diff_spons_dfe_mail_us_address2 := le.spons_dfe_mail_us_address2 <> ri.spons_dfe_mail_us_address2;
    SELF.Diff_spons_dfe_mail_us_city := le.spons_dfe_mail_us_city <> ri.spons_dfe_mail_us_city;
    SELF.Diff_spons_dfe_mail_us_state := le.spons_dfe_mail_us_state <> ri.spons_dfe_mail_us_state;
    SELF.Diff_spons_dfe_mail_us_zip := le.spons_dfe_mail_us_zip <> ri.spons_dfe_mail_us_zip;
    SELF.Diff_spons_dfe_mail_foreign_addr1 := le.spons_dfe_mail_foreign_addr1 <> ri.spons_dfe_mail_foreign_addr1;
    SELF.Diff_spons_dfe_mail_foreign_addr2 := le.spons_dfe_mail_foreign_addr2 <> ri.spons_dfe_mail_foreign_addr2;
    SELF.Diff_spons_dfe_mail_foreign_city := le.spons_dfe_mail_foreign_city <> ri.spons_dfe_mail_foreign_city;
    SELF.Diff_spons_dfe_mail_forgn_prov_st := le.spons_dfe_mail_forgn_prov_st <> ri.spons_dfe_mail_forgn_prov_st;
    SELF.Diff_spons_dfe_mail_foreign_cntry := le.spons_dfe_mail_foreign_cntry <> ri.spons_dfe_mail_foreign_cntry;
    SELF.Diff_spons_dfe_mail_forgn_postal_cd := le.spons_dfe_mail_forgn_postal_cd <> ri.spons_dfe_mail_forgn_postal_cd;
    SELF.Diff_spons_dfe_loc_us_address1 := le.spons_dfe_loc_us_address1 <> ri.spons_dfe_loc_us_address1;
    SELF.Diff_spons_dfe_loc_us_address2 := le.spons_dfe_loc_us_address2 <> ri.spons_dfe_loc_us_address2;
    SELF.Diff_spons_dfe_loc_us_city := le.spons_dfe_loc_us_city <> ri.spons_dfe_loc_us_city;
    SELF.Diff_spons_dfe_loc_us_state := le.spons_dfe_loc_us_state <> ri.spons_dfe_loc_us_state;
    SELF.Diff_spons_dfe_loc_us_zip := le.spons_dfe_loc_us_zip <> ri.spons_dfe_loc_us_zip;
    SELF.Diff_spons_dfe_loc_foreign_address1 := le.spons_dfe_loc_foreign_address1 <> ri.spons_dfe_loc_foreign_address1;
    SELF.Diff_spons_dfe_loc_foreign_address2 := le.spons_dfe_loc_foreign_address2 <> ri.spons_dfe_loc_foreign_address2;
    SELF.Diff_spons_dfe_loc_foreign_city := le.spons_dfe_loc_foreign_city <> ri.spons_dfe_loc_foreign_city;
    SELF.Diff_spons_dfe_loc_forgn_prov_st := le.spons_dfe_loc_forgn_prov_st <> ri.spons_dfe_loc_forgn_prov_st;
    SELF.Diff_spons_dfe_loc_foreign_cntry := le.spons_dfe_loc_foreign_cntry <> ri.spons_dfe_loc_foreign_cntry;
    SELF.Diff_spons_dfe_loc_forgn_postal_cd := le.spons_dfe_loc_forgn_postal_cd <> ri.spons_dfe_loc_forgn_postal_cd;
    SELF.Diff_spons_dfe_ein := le.spons_dfe_ein <> ri.spons_dfe_ein;
    SELF.Diff_spons_dfe_phone_num := le.spons_dfe_phone_num <> ri.spons_dfe_phone_num;
    SELF.Diff_business_code := le.business_code <> ri.business_code;
    SELF.Diff_admin_name := le.admin_name <> ri.admin_name;
    SELF.Diff_admin_care_of_name := le.admin_care_of_name <> ri.admin_care_of_name;
    SELF.Diff_admin_us_address1 := le.admin_us_address1 <> ri.admin_us_address1;
    SELF.Diff_admin_us_address2 := le.admin_us_address2 <> ri.admin_us_address2;
    SELF.Diff_admin_us_city := le.admin_us_city <> ri.admin_us_city;
    SELF.Diff_admin_us_state := le.admin_us_state <> ri.admin_us_state;
    SELF.Diff_admin_us_zip := le.admin_us_zip <> ri.admin_us_zip;
    SELF.Diff_admin_foreign_address1 := le.admin_foreign_address1 <> ri.admin_foreign_address1;
    SELF.Diff_admin_foreign_address2 := le.admin_foreign_address2 <> ri.admin_foreign_address2;
    SELF.Diff_admin_foreign_city := le.admin_foreign_city <> ri.admin_foreign_city;
    SELF.Diff_admin_foreign_prov_state := le.admin_foreign_prov_state <> ri.admin_foreign_prov_state;
    SELF.Diff_admin_foreign_cntry := le.admin_foreign_cntry <> ri.admin_foreign_cntry;
    SELF.Diff_admin_foreign_postal_cd := le.admin_foreign_postal_cd <> ri.admin_foreign_postal_cd;
    SELF.Diff_admin_ein := le.admin_ein <> ri.admin_ein;
    SELF.Diff_admin_phone_num := le.admin_phone_num <> ri.admin_phone_num;
    SELF.Diff_last_rpt_spons_name := le.last_rpt_spons_name <> ri.last_rpt_spons_name;
    SELF.Diff_last_rpt_spons_ein := le.last_rpt_spons_ein <> ri.last_rpt_spons_ein;
    SELF.Diff_last_rpt_plan_num := le.last_rpt_plan_num <> ri.last_rpt_plan_num;
    SELF.Diff_admin_signed_date := le.admin_signed_date <> ri.admin_signed_date;
    SELF.Diff_admin_signed_name := le.admin_signed_name <> ri.admin_signed_name;
    SELF.Diff_spons_signed_date := le.spons_signed_date <> ri.spons_signed_date;
    SELF.Diff_spons_signed_name := le.spons_signed_name <> ri.spons_signed_name;
    SELF.Diff_dfe_signed_date := le.dfe_signed_date <> ri.dfe_signed_date;
    SELF.Diff_dfe_signed_name := le.dfe_signed_name <> ri.dfe_signed_name;
    SELF.Diff_tot_partcp_boy_cnt := le.tot_partcp_boy_cnt <> ri.tot_partcp_boy_cnt;
    SELF.Diff_tot_active_partcp_cnt := le.tot_active_partcp_cnt <> ri.tot_active_partcp_cnt;
    SELF.Diff_rtd_sep_partcp_rcvg_cnt := le.rtd_sep_partcp_rcvg_cnt <> ri.rtd_sep_partcp_rcvg_cnt;
    SELF.Diff_rtd_sep_partcp_fut_cnt := le.rtd_sep_partcp_fut_cnt <> ri.rtd_sep_partcp_fut_cnt;
    SELF.Diff_subtl_act_rtd_sep_cnt := le.subtl_act_rtd_sep_cnt <> ri.subtl_act_rtd_sep_cnt;
    SELF.Diff_benef_rcvg_bnft_cnt := le.benef_rcvg_bnft_cnt <> ri.benef_rcvg_bnft_cnt;
    SELF.Diff_tot_act_rtd_sep_benef_cnt := le.tot_act_rtd_sep_benef_cnt <> ri.tot_act_rtd_sep_benef_cnt;
    SELF.Diff_partcp_account_bal_cnt := le.partcp_account_bal_cnt <> ri.partcp_account_bal_cnt;
    SELF.Diff_sep_partcp_partl_vstd_cnt := le.sep_partcp_partl_vstd_cnt <> ri.sep_partcp_partl_vstd_cnt;
    SELF.Diff_contrib_emplrs_cnt := le.contrib_emplrs_cnt <> ri.contrib_emplrs_cnt;
    SELF.Diff_type_pension_bnft_code := le.type_pension_bnft_code <> ri.type_pension_bnft_code;
    SELF.Diff_type_welfare_bnft_code := le.type_welfare_bnft_code <> ri.type_welfare_bnft_code;
    SELF.Diff_funding_insurance_ind := le.funding_insurance_ind <> ri.funding_insurance_ind;
    SELF.Diff_funding_sec412_ind := le.funding_sec412_ind <> ri.funding_sec412_ind;
    SELF.Diff_funding_trust_ind := le.funding_trust_ind <> ri.funding_trust_ind;
    SELF.Diff_funding_gen_asset_ind := le.funding_gen_asset_ind <> ri.funding_gen_asset_ind;
    SELF.Diff_benefit_insurance_ind := le.benefit_insurance_ind <> ri.benefit_insurance_ind;
    SELF.Diff_benefit_sec412_ind := le.benefit_sec412_ind <> ri.benefit_sec412_ind;
    SELF.Diff_benefit_trust_ind := le.benefit_trust_ind <> ri.benefit_trust_ind;
    SELF.Diff_benefit_gen_asset_ind := le.benefit_gen_asset_ind <> ri.benefit_gen_asset_ind;
    SELF.Diff_sch_r_attached_ind := le.sch_r_attached_ind <> ri.sch_r_attached_ind;
    SELF.Diff_sch_mb_attached_ind := le.sch_mb_attached_ind <> ri.sch_mb_attached_ind;
    SELF.Diff_sch_sb_attached_ind := le.sch_sb_attached_ind <> ri.sch_sb_attached_ind;
    SELF.Diff_sch_h_attached_ind := le.sch_h_attached_ind <> ri.sch_h_attached_ind;
    SELF.Diff_sch_i_attached_ind := le.sch_i_attached_ind <> ri.sch_i_attached_ind;
    SELF.Diff_sch_a_attached_ind := le.sch_a_attached_ind <> ri.sch_a_attached_ind;
    SELF.Diff_num_sch_a_attached_cnt := le.num_sch_a_attached_cnt <> ri.num_sch_a_attached_cnt;
    SELF.Diff_sch_c_attached_ind := le.sch_c_attached_ind <> ri.sch_c_attached_ind;
    SELF.Diff_sch_d_attached_ind := le.sch_d_attached_ind <> ri.sch_d_attached_ind;
    SELF.Diff_sch_g_attached_ind := le.sch_g_attached_ind <> ri.sch_g_attached_ind;
    SELF.Diff_filing_status := le.filing_status <> ri.filing_status;
    SELF.Diff_date_received := le.date_received <> ri.date_received;
    SELF.Diff_valid_admin_signature := le.valid_admin_signature <> ri.valid_admin_signature;
    SELF.Diff_valid_dfe_signature := le.valid_dfe_signature <> ri.valid_dfe_signature;
    SELF.Diff_valid_sponsor_signature := le.valid_sponsor_signature <> ri.valid_sponsor_signature;
    SELF.Diff_admin_phone_num_foreign := le.admin_phone_num_foreign <> ri.admin_phone_num_foreign;
    SELF.Diff_spons_dfe_phone_num_foreign := le.spons_dfe_phone_num_foreign <> ri.spons_dfe_phone_num_foreign;
    SELF.Diff_admin_name_same_spon_ind := le.admin_name_same_spon_ind <> ri.admin_name_same_spon_ind;
    SELF.Diff_admin_address_same_spon_ind := le.admin_address_same_spon_ind <> ri.admin_address_same_spon_ind;
    SELF.Diff_preparer_name := le.preparer_name <> ri.preparer_name;
    SELF.Diff_preparer_firm_name := le.preparer_firm_name <> ri.preparer_firm_name;
    SELF.Diff_preparer_us_address1 := le.preparer_us_address1 <> ri.preparer_us_address1;
    SELF.Diff_preparer_us_address2 := le.preparer_us_address2 <> ri.preparer_us_address2;
    SELF.Diff_preparer_us_city := le.preparer_us_city <> ri.preparer_us_city;
    SELF.Diff_preparer_us_state := le.preparer_us_state <> ri.preparer_us_state;
    SELF.Diff_preparer_us_zip := le.preparer_us_zip <> ri.preparer_us_zip;
    SELF.Diff_preparer_foreign_address1 := le.preparer_foreign_address1 <> ri.preparer_foreign_address1;
    SELF.Diff_preparer_foreign_address2 := le.preparer_foreign_address2 <> ri.preparer_foreign_address2;
    SELF.Diff_preparer_foreign_city := le.preparer_foreign_city <> ri.preparer_foreign_city;
    SELF.Diff_preparer_foreign_prov_state := le.preparer_foreign_prov_state <> ri.preparer_foreign_prov_state;
    SELF.Diff_preparer_foreign_cntry := le.preparer_foreign_cntry <> ri.preparer_foreign_cntry;
    SELF.Diff_preparer_foreign_postal_cd := le.preparer_foreign_postal_cd <> ri.preparer_foreign_postal_cd;
    SELF.Diff_preparer_phone_num := le.preparer_phone_num <> ri.preparer_phone_num;
    SELF.Diff_preparer_phone_num_foreign := le.preparer_phone_num_foreign <> ri.preparer_phone_num_foreign;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ack_id,1,0)+ IF( SELF.Diff_form_plan_year_begin_date,1,0)+ IF( SELF.Diff_form_tax_prd,1,0)+ IF( SELF.Diff_type_plan_entity_cd,1,0)+ IF( SELF.Diff_type_dfe_plan_entity_cd,1,0)+ IF( SELF.Diff_initial_filing_ind,1,0)+ IF( SELF.Diff_amended_ind,1,0)+ IF( SELF.Diff_final_filing_ind,1,0)+ IF( SELF.Diff_short_plan_yr_ind,1,0)+ IF( SELF.Diff_collective_bargain_ind,1,0)+ IF( SELF.Diff_f5558_application_filed_ind,1,0)+ IF( SELF.Diff_ext_automatic_ind,1,0)+ IF( SELF.Diff_dfvc_program_ind,1,0)+ IF( SELF.Diff_ext_special_ind,1,0)+ IF( SELF.Diff_ext_special_text,1,0)+ IF( SELF.Diff_plan_name,1,0)+ IF( SELF.Diff_spons_dfe_pn,1,0)+ IF( SELF.Diff_plan_eff_date,1,0)+ IF( SELF.Diff_sponsor_dfe_name,1,0)+ IF( SELF.Diff_spons_dfe_dba_name,1,0)+ IF( SELF.Diff_spons_dfe_care_of_name,1,0)+ IF( SELF.Diff_spons_dfe_mail_us_address1,1,0)+ IF( SELF.Diff_spons_dfe_mail_us_address2,1,0)+ IF( SELF.Diff_spons_dfe_mail_us_city,1,0)+ IF( SELF.Diff_spons_dfe_mail_us_state,1,0)+ IF( SELF.Diff_spons_dfe_mail_us_zip,1,0)+ IF( SELF.Diff_spons_dfe_mail_foreign_addr1,1,0)+ IF( SELF.Diff_spons_dfe_mail_foreign_addr2,1,0)+ IF( SELF.Diff_spons_dfe_mail_foreign_city,1,0)+ IF( SELF.Diff_spons_dfe_mail_forgn_prov_st,1,0)+ IF( SELF.Diff_spons_dfe_mail_foreign_cntry,1,0)+ IF( SELF.Diff_spons_dfe_mail_forgn_postal_cd,1,0)+ IF( SELF.Diff_spons_dfe_loc_us_address1,1,0)+ IF( SELF.Diff_spons_dfe_loc_us_address2,1,0)+ IF( SELF.Diff_spons_dfe_loc_us_city,1,0)+ IF( SELF.Diff_spons_dfe_loc_us_state,1,0)+ IF( SELF.Diff_spons_dfe_loc_us_zip,1,0)+ IF( SELF.Diff_spons_dfe_loc_foreign_address1,1,0)+ IF( SELF.Diff_spons_dfe_loc_foreign_address2,1,0)+ IF( SELF.Diff_spons_dfe_loc_foreign_city,1,0)+ IF( SELF.Diff_spons_dfe_loc_forgn_prov_st,1,0)+ IF( SELF.Diff_spons_dfe_loc_foreign_cntry,1,0)+ IF( SELF.Diff_spons_dfe_loc_forgn_postal_cd,1,0)+ IF( SELF.Diff_spons_dfe_ein,1,0)+ IF( SELF.Diff_spons_dfe_phone_num,1,0)+ IF( SELF.Diff_business_code,1,0)+ IF( SELF.Diff_admin_name,1,0)+ IF( SELF.Diff_admin_care_of_name,1,0)+ IF( SELF.Diff_admin_us_address1,1,0)+ IF( SELF.Diff_admin_us_address2,1,0)+ IF( SELF.Diff_admin_us_city,1,0)+ IF( SELF.Diff_admin_us_state,1,0)+ IF( SELF.Diff_admin_us_zip,1,0)+ IF( SELF.Diff_admin_foreign_address1,1,0)+ IF( SELF.Diff_admin_foreign_address2,1,0)+ IF( SELF.Diff_admin_foreign_city,1,0)+ IF( SELF.Diff_admin_foreign_prov_state,1,0)+ IF( SELF.Diff_admin_foreign_cntry,1,0)+ IF( SELF.Diff_admin_foreign_postal_cd,1,0)+ IF( SELF.Diff_admin_ein,1,0)+ IF( SELF.Diff_admin_phone_num,1,0)+ IF( SELF.Diff_last_rpt_spons_name,1,0)+ IF( SELF.Diff_last_rpt_spons_ein,1,0)+ IF( SELF.Diff_last_rpt_plan_num,1,0)+ IF( SELF.Diff_admin_signed_date,1,0)+ IF( SELF.Diff_admin_signed_name,1,0)+ IF( SELF.Diff_spons_signed_date,1,0)+ IF( SELF.Diff_spons_signed_name,1,0)+ IF( SELF.Diff_dfe_signed_date,1,0)+ IF( SELF.Diff_dfe_signed_name,1,0)+ IF( SELF.Diff_tot_partcp_boy_cnt,1,0)+ IF( SELF.Diff_tot_active_partcp_cnt,1,0)+ IF( SELF.Diff_rtd_sep_partcp_rcvg_cnt,1,0)+ IF( SELF.Diff_rtd_sep_partcp_fut_cnt,1,0)+ IF( SELF.Diff_subtl_act_rtd_sep_cnt,1,0)+ IF( SELF.Diff_benef_rcvg_bnft_cnt,1,0)+ IF( SELF.Diff_tot_act_rtd_sep_benef_cnt,1,0)+ IF( SELF.Diff_partcp_account_bal_cnt,1,0)+ IF( SELF.Diff_sep_partcp_partl_vstd_cnt,1,0)+ IF( SELF.Diff_contrib_emplrs_cnt,1,0)+ IF( SELF.Diff_type_pension_bnft_code,1,0)+ IF( SELF.Diff_type_welfare_bnft_code,1,0)+ IF( SELF.Diff_funding_insurance_ind,1,0)+ IF( SELF.Diff_funding_sec412_ind,1,0)+ IF( SELF.Diff_funding_trust_ind,1,0)+ IF( SELF.Diff_funding_gen_asset_ind,1,0)+ IF( SELF.Diff_benefit_insurance_ind,1,0)+ IF( SELF.Diff_benefit_sec412_ind,1,0)+ IF( SELF.Diff_benefit_trust_ind,1,0)+ IF( SELF.Diff_benefit_gen_asset_ind,1,0)+ IF( SELF.Diff_sch_r_attached_ind,1,0)+ IF( SELF.Diff_sch_mb_attached_ind,1,0)+ IF( SELF.Diff_sch_sb_attached_ind,1,0)+ IF( SELF.Diff_sch_h_attached_ind,1,0)+ IF( SELF.Diff_sch_i_attached_ind,1,0)+ IF( SELF.Diff_sch_a_attached_ind,1,0)+ IF( SELF.Diff_num_sch_a_attached_cnt,1,0)+ IF( SELF.Diff_sch_c_attached_ind,1,0)+ IF( SELF.Diff_sch_d_attached_ind,1,0)+ IF( SELF.Diff_sch_g_attached_ind,1,0)+ IF( SELF.Diff_filing_status,1,0)+ IF( SELF.Diff_date_received,1,0)+ IF( SELF.Diff_valid_admin_signature,1,0)+ IF( SELF.Diff_valid_dfe_signature,1,0)+ IF( SELF.Diff_valid_sponsor_signature,1,0)+ IF( SELF.Diff_admin_phone_num_foreign,1,0)+ IF( SELF.Diff_spons_dfe_phone_num_foreign,1,0)+ IF( SELF.Diff_admin_name_same_spon_ind,1,0)+ IF( SELF.Diff_admin_address_same_spon_ind,1,0)+ IF( SELF.Diff_preparer_name,1,0)+ IF( SELF.Diff_preparer_firm_name,1,0)+ IF( SELF.Diff_preparer_us_address1,1,0)+ IF( SELF.Diff_preparer_us_address2,1,0)+ IF( SELF.Diff_preparer_us_city,1,0)+ IF( SELF.Diff_preparer_us_state,1,0)+ IF( SELF.Diff_preparer_us_zip,1,0)+ IF( SELF.Diff_preparer_foreign_address1,1,0)+ IF( SELF.Diff_preparer_foreign_address2,1,0)+ IF( SELF.Diff_preparer_foreign_city,1,0)+ IF( SELF.Diff_preparer_foreign_prov_state,1,0)+ IF( SELF.Diff_preparer_foreign_cntry,1,0)+ IF( SELF.Diff_preparer_foreign_postal_cd,1,0)+ IF( SELF.Diff_preparer_phone_num,1,0)+ IF( SELF.Diff_preparer_phone_num_foreign,1,0);
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
    Count_Diff_ack_id := COUNT(GROUP,%Closest%.Diff_ack_id);
    Count_Diff_form_plan_year_begin_date := COUNT(GROUP,%Closest%.Diff_form_plan_year_begin_date);
    Count_Diff_form_tax_prd := COUNT(GROUP,%Closest%.Diff_form_tax_prd);
    Count_Diff_type_plan_entity_cd := COUNT(GROUP,%Closest%.Diff_type_plan_entity_cd);
    Count_Diff_type_dfe_plan_entity_cd := COUNT(GROUP,%Closest%.Diff_type_dfe_plan_entity_cd);
    Count_Diff_initial_filing_ind := COUNT(GROUP,%Closest%.Diff_initial_filing_ind);
    Count_Diff_amended_ind := COUNT(GROUP,%Closest%.Diff_amended_ind);
    Count_Diff_final_filing_ind := COUNT(GROUP,%Closest%.Diff_final_filing_ind);
    Count_Diff_short_plan_yr_ind := COUNT(GROUP,%Closest%.Diff_short_plan_yr_ind);
    Count_Diff_collective_bargain_ind := COUNT(GROUP,%Closest%.Diff_collective_bargain_ind);
    Count_Diff_f5558_application_filed_ind := COUNT(GROUP,%Closest%.Diff_f5558_application_filed_ind);
    Count_Diff_ext_automatic_ind := COUNT(GROUP,%Closest%.Diff_ext_automatic_ind);
    Count_Diff_dfvc_program_ind := COUNT(GROUP,%Closest%.Diff_dfvc_program_ind);
    Count_Diff_ext_special_ind := COUNT(GROUP,%Closest%.Diff_ext_special_ind);
    Count_Diff_ext_special_text := COUNT(GROUP,%Closest%.Diff_ext_special_text);
    Count_Diff_plan_name := COUNT(GROUP,%Closest%.Diff_plan_name);
    Count_Diff_spons_dfe_pn := COUNT(GROUP,%Closest%.Diff_spons_dfe_pn);
    Count_Diff_plan_eff_date := COUNT(GROUP,%Closest%.Diff_plan_eff_date);
    Count_Diff_sponsor_dfe_name := COUNT(GROUP,%Closest%.Diff_sponsor_dfe_name);
    Count_Diff_spons_dfe_dba_name := COUNT(GROUP,%Closest%.Diff_spons_dfe_dba_name);
    Count_Diff_spons_dfe_care_of_name := COUNT(GROUP,%Closest%.Diff_spons_dfe_care_of_name);
    Count_Diff_spons_dfe_mail_us_address1 := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_us_address1);
    Count_Diff_spons_dfe_mail_us_address2 := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_us_address2);
    Count_Diff_spons_dfe_mail_us_city := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_us_city);
    Count_Diff_spons_dfe_mail_us_state := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_us_state);
    Count_Diff_spons_dfe_mail_us_zip := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_us_zip);
    Count_Diff_spons_dfe_mail_foreign_addr1 := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_foreign_addr1);
    Count_Diff_spons_dfe_mail_foreign_addr2 := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_foreign_addr2);
    Count_Diff_spons_dfe_mail_foreign_city := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_foreign_city);
    Count_Diff_spons_dfe_mail_forgn_prov_st := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_forgn_prov_st);
    Count_Diff_spons_dfe_mail_foreign_cntry := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_foreign_cntry);
    Count_Diff_spons_dfe_mail_forgn_postal_cd := COUNT(GROUP,%Closest%.Diff_spons_dfe_mail_forgn_postal_cd);
    Count_Diff_spons_dfe_loc_us_address1 := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_us_address1);
    Count_Diff_spons_dfe_loc_us_address2 := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_us_address2);
    Count_Diff_spons_dfe_loc_us_city := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_us_city);
    Count_Diff_spons_dfe_loc_us_state := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_us_state);
    Count_Diff_spons_dfe_loc_us_zip := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_us_zip);
    Count_Diff_spons_dfe_loc_foreign_address1 := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_foreign_address1);
    Count_Diff_spons_dfe_loc_foreign_address2 := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_foreign_address2);
    Count_Diff_spons_dfe_loc_foreign_city := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_foreign_city);
    Count_Diff_spons_dfe_loc_forgn_prov_st := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_forgn_prov_st);
    Count_Diff_spons_dfe_loc_foreign_cntry := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_foreign_cntry);
    Count_Diff_spons_dfe_loc_forgn_postal_cd := COUNT(GROUP,%Closest%.Diff_spons_dfe_loc_forgn_postal_cd);
    Count_Diff_spons_dfe_ein := COUNT(GROUP,%Closest%.Diff_spons_dfe_ein);
    Count_Diff_spons_dfe_phone_num := COUNT(GROUP,%Closest%.Diff_spons_dfe_phone_num);
    Count_Diff_business_code := COUNT(GROUP,%Closest%.Diff_business_code);
    Count_Diff_admin_name := COUNT(GROUP,%Closest%.Diff_admin_name);
    Count_Diff_admin_care_of_name := COUNT(GROUP,%Closest%.Diff_admin_care_of_name);
    Count_Diff_admin_us_address1 := COUNT(GROUP,%Closest%.Diff_admin_us_address1);
    Count_Diff_admin_us_address2 := COUNT(GROUP,%Closest%.Diff_admin_us_address2);
    Count_Diff_admin_us_city := COUNT(GROUP,%Closest%.Diff_admin_us_city);
    Count_Diff_admin_us_state := COUNT(GROUP,%Closest%.Diff_admin_us_state);
    Count_Diff_admin_us_zip := COUNT(GROUP,%Closest%.Diff_admin_us_zip);
    Count_Diff_admin_foreign_address1 := COUNT(GROUP,%Closest%.Diff_admin_foreign_address1);
    Count_Diff_admin_foreign_address2 := COUNT(GROUP,%Closest%.Diff_admin_foreign_address2);
    Count_Diff_admin_foreign_city := COUNT(GROUP,%Closest%.Diff_admin_foreign_city);
    Count_Diff_admin_foreign_prov_state := COUNT(GROUP,%Closest%.Diff_admin_foreign_prov_state);
    Count_Diff_admin_foreign_cntry := COUNT(GROUP,%Closest%.Diff_admin_foreign_cntry);
    Count_Diff_admin_foreign_postal_cd := COUNT(GROUP,%Closest%.Diff_admin_foreign_postal_cd);
    Count_Diff_admin_ein := COUNT(GROUP,%Closest%.Diff_admin_ein);
    Count_Diff_admin_phone_num := COUNT(GROUP,%Closest%.Diff_admin_phone_num);
    Count_Diff_last_rpt_spons_name := COUNT(GROUP,%Closest%.Diff_last_rpt_spons_name);
    Count_Diff_last_rpt_spons_ein := COUNT(GROUP,%Closest%.Diff_last_rpt_spons_ein);
    Count_Diff_last_rpt_plan_num := COUNT(GROUP,%Closest%.Diff_last_rpt_plan_num);
    Count_Diff_admin_signed_date := COUNT(GROUP,%Closest%.Diff_admin_signed_date);
    Count_Diff_admin_signed_name := COUNT(GROUP,%Closest%.Diff_admin_signed_name);
    Count_Diff_spons_signed_date := COUNT(GROUP,%Closest%.Diff_spons_signed_date);
    Count_Diff_spons_signed_name := COUNT(GROUP,%Closest%.Diff_spons_signed_name);
    Count_Diff_dfe_signed_date := COUNT(GROUP,%Closest%.Diff_dfe_signed_date);
    Count_Diff_dfe_signed_name := COUNT(GROUP,%Closest%.Diff_dfe_signed_name);
    Count_Diff_tot_partcp_boy_cnt := COUNT(GROUP,%Closest%.Diff_tot_partcp_boy_cnt);
    Count_Diff_tot_active_partcp_cnt := COUNT(GROUP,%Closest%.Diff_tot_active_partcp_cnt);
    Count_Diff_rtd_sep_partcp_rcvg_cnt := COUNT(GROUP,%Closest%.Diff_rtd_sep_partcp_rcvg_cnt);
    Count_Diff_rtd_sep_partcp_fut_cnt := COUNT(GROUP,%Closest%.Diff_rtd_sep_partcp_fut_cnt);
    Count_Diff_subtl_act_rtd_sep_cnt := COUNT(GROUP,%Closest%.Diff_subtl_act_rtd_sep_cnt);
    Count_Diff_benef_rcvg_bnft_cnt := COUNT(GROUP,%Closest%.Diff_benef_rcvg_bnft_cnt);
    Count_Diff_tot_act_rtd_sep_benef_cnt := COUNT(GROUP,%Closest%.Diff_tot_act_rtd_sep_benef_cnt);
    Count_Diff_partcp_account_bal_cnt := COUNT(GROUP,%Closest%.Diff_partcp_account_bal_cnt);
    Count_Diff_sep_partcp_partl_vstd_cnt := COUNT(GROUP,%Closest%.Diff_sep_partcp_partl_vstd_cnt);
    Count_Diff_contrib_emplrs_cnt := COUNT(GROUP,%Closest%.Diff_contrib_emplrs_cnt);
    Count_Diff_type_pension_bnft_code := COUNT(GROUP,%Closest%.Diff_type_pension_bnft_code);
    Count_Diff_type_welfare_bnft_code := COUNT(GROUP,%Closest%.Diff_type_welfare_bnft_code);
    Count_Diff_funding_insurance_ind := COUNT(GROUP,%Closest%.Diff_funding_insurance_ind);
    Count_Diff_funding_sec412_ind := COUNT(GROUP,%Closest%.Diff_funding_sec412_ind);
    Count_Diff_funding_trust_ind := COUNT(GROUP,%Closest%.Diff_funding_trust_ind);
    Count_Diff_funding_gen_asset_ind := COUNT(GROUP,%Closest%.Diff_funding_gen_asset_ind);
    Count_Diff_benefit_insurance_ind := COUNT(GROUP,%Closest%.Diff_benefit_insurance_ind);
    Count_Diff_benefit_sec412_ind := COUNT(GROUP,%Closest%.Diff_benefit_sec412_ind);
    Count_Diff_benefit_trust_ind := COUNT(GROUP,%Closest%.Diff_benefit_trust_ind);
    Count_Diff_benefit_gen_asset_ind := COUNT(GROUP,%Closest%.Diff_benefit_gen_asset_ind);
    Count_Diff_sch_r_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_r_attached_ind);
    Count_Diff_sch_mb_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_mb_attached_ind);
    Count_Diff_sch_sb_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_sb_attached_ind);
    Count_Diff_sch_h_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_h_attached_ind);
    Count_Diff_sch_i_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_i_attached_ind);
    Count_Diff_sch_a_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_a_attached_ind);
    Count_Diff_num_sch_a_attached_cnt := COUNT(GROUP,%Closest%.Diff_num_sch_a_attached_cnt);
    Count_Diff_sch_c_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_c_attached_ind);
    Count_Diff_sch_d_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_d_attached_ind);
    Count_Diff_sch_g_attached_ind := COUNT(GROUP,%Closest%.Diff_sch_g_attached_ind);
    Count_Diff_filing_status := COUNT(GROUP,%Closest%.Diff_filing_status);
    Count_Diff_date_received := COUNT(GROUP,%Closest%.Diff_date_received);
    Count_Diff_valid_admin_signature := COUNT(GROUP,%Closest%.Diff_valid_admin_signature);
    Count_Diff_valid_dfe_signature := COUNT(GROUP,%Closest%.Diff_valid_dfe_signature);
    Count_Diff_valid_sponsor_signature := COUNT(GROUP,%Closest%.Diff_valid_sponsor_signature);
    Count_Diff_admin_phone_num_foreign := COUNT(GROUP,%Closest%.Diff_admin_phone_num_foreign);
    Count_Diff_spons_dfe_phone_num_foreign := COUNT(GROUP,%Closest%.Diff_spons_dfe_phone_num_foreign);
    Count_Diff_admin_name_same_spon_ind := COUNT(GROUP,%Closest%.Diff_admin_name_same_spon_ind);
    Count_Diff_admin_address_same_spon_ind := COUNT(GROUP,%Closest%.Diff_admin_address_same_spon_ind);
    Count_Diff_preparer_name := COUNT(GROUP,%Closest%.Diff_preparer_name);
    Count_Diff_preparer_firm_name := COUNT(GROUP,%Closest%.Diff_preparer_firm_name);
    Count_Diff_preparer_us_address1 := COUNT(GROUP,%Closest%.Diff_preparer_us_address1);
    Count_Diff_preparer_us_address2 := COUNT(GROUP,%Closest%.Diff_preparer_us_address2);
    Count_Diff_preparer_us_city := COUNT(GROUP,%Closest%.Diff_preparer_us_city);
    Count_Diff_preparer_us_state := COUNT(GROUP,%Closest%.Diff_preparer_us_state);
    Count_Diff_preparer_us_zip := COUNT(GROUP,%Closest%.Diff_preparer_us_zip);
    Count_Diff_preparer_foreign_address1 := COUNT(GROUP,%Closest%.Diff_preparer_foreign_address1);
    Count_Diff_preparer_foreign_address2 := COUNT(GROUP,%Closest%.Diff_preparer_foreign_address2);
    Count_Diff_preparer_foreign_city := COUNT(GROUP,%Closest%.Diff_preparer_foreign_city);
    Count_Diff_preparer_foreign_prov_state := COUNT(GROUP,%Closest%.Diff_preparer_foreign_prov_state);
    Count_Diff_preparer_foreign_cntry := COUNT(GROUP,%Closest%.Diff_preparer_foreign_cntry);
    Count_Diff_preparer_foreign_postal_cd := COUNT(GROUP,%Closest%.Diff_preparer_foreign_postal_cd);
    Count_Diff_preparer_phone_num := COUNT(GROUP,%Closest%.Diff_preparer_phone_num);
    Count_Diff_preparer_phone_num_foreign := COUNT(GROUP,%Closest%.Diff_preparer_phone_num_foreign);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
