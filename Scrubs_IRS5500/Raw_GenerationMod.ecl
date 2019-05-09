// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_IRS5500';
  EXPORT spc_NAMESCOPE := 'Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'IRS5500';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ack_id,form_plan_year_begin_date,form_tax_prd,type_plan_entity_cd,type_dfe_plan_entity_cd,initial_filing_ind,amended_ind,final_filing_ind,short_plan_yr_ind,collective_bargain_ind,f5558_application_filed_ind,ext_automatic_ind,dfvc_program_ind,ext_special_ind,ext_special_text,plan_name,spons_dfe_pn,plan_eff_date,sponsor_dfe_name,spons_dfe_dba_name,spons_dfe_care_of_name,spons_dfe_mail_us_address1,spons_dfe_mail_us_address2,spons_dfe_mail_us_city,spons_dfe_mail_us_state,spons_dfe_mail_us_zip,spons_dfe_mail_foreign_addr1,spons_dfe_mail_foreign_addr2,spons_dfe_mail_foreign_city,spons_dfe_mail_forgn_prov_st,spons_dfe_mail_foreign_cntry,spons_dfe_mail_forgn_postal_cd,spons_dfe_loc_us_address1,spons_dfe_loc_us_address2,spons_dfe_loc_us_city,spons_dfe_loc_us_state,spons_dfe_loc_us_zip,spons_dfe_loc_foreign_address1,spons_dfe_loc_foreign_address2,spons_dfe_loc_foreign_city,spons_dfe_loc_forgn_prov_st,spons_dfe_loc_foreign_cntry,spons_dfe_loc_forgn_postal_cd,spons_dfe_ein,spons_dfe_phone_num,business_code,admin_name,admin_care_of_name,admin_us_address1,admin_us_address2,admin_us_city,admin_us_state,admin_us_zip,admin_foreign_address1,admin_foreign_address2,admin_foreign_city,admin_foreign_prov_state,admin_foreign_cntry,admin_foreign_postal_cd,admin_ein,admin_phone_num,last_rpt_spons_name,last_rpt_spons_ein,last_rpt_plan_num,admin_signed_date,admin_signed_name,spons_signed_date,spons_signed_name,dfe_signed_date,dfe_signed_name,tot_partcp_boy_cnt,tot_active_partcp_cnt,rtd_sep_partcp_rcvg_cnt,rtd_sep_partcp_fut_cnt,subtl_act_rtd_sep_cnt,benef_rcvg_bnft_cnt,tot_act_rtd_sep_benef_cnt,partcp_account_bal_cnt,sep_partcp_partl_vstd_cnt,contrib_emplrs_cnt,type_pension_bnft_code,type_welfare_bnft_code,funding_insurance_ind,funding_sec412_ind,funding_trust_ind,funding_gen_asset_ind,benefit_insurance_ind,benefit_sec412_ind,benefit_trust_ind,benefit_gen_asset_ind,sch_r_attached_ind,sch_mb_attached_ind,sch_sb_attached_ind,sch_h_attached_ind,sch_i_attached_ind,sch_a_attached_ind,num_sch_a_attached_cnt,sch_c_attached_ind,sch_d_attached_ind,sch_g_attached_ind,filing_status,date_received,valid_admin_signature,valid_dfe_signature,valid_sponsor_signature,admin_phone_num_foreign,spons_dfe_phone_num_foreign,admin_name_same_spon_ind,admin_address_same_spon_ind,preparer_name,preparer_firm_name,preparer_us_address1,preparer_us_address2,preparer_us_city,preparer_us_state,preparer_us_zip,preparer_foreign_address1,preparer_foreign_address2,preparer_foreign_city,preparer_foreign_prov_state,preparer_foreign_cntry,preparer_foreign_postal_cd,preparer_phone_num,preparer_phone_num_foreign';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_IRS5500\n'
    + 'FILENAME:IRS5500\n'
    + 'NAMESCOPE:Raw\n'
    + '\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + 'FIELDTYPE:invalid_ack_id:ALLOW(0123456789P)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_IRS5500.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_IRS5500.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_generaldate:CUSTOM(Scrubs_IRS5500.Functions.fn_valid_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_type_plan_entity_cd:ENUM(0|1|2|3|4|)\n'
    + 'FIELDTYPE:invalid_type_dfe_plan_entity_cd:ENUM(C|E|G|M|P|)\n'
    + 'FIELDTYPE:invalid_zero_1_bk:ENUM(0|1|)\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_names>0) \n'
    + 'FIELDTYPE:invalid_type_pension_bnft_code:ALLOW(123ABCDEFGHIJKLMNOPQRST )\n'
    + 'FIELDTYPE:invalid_type_welfare_bnft_code:ALLOW(4ABCDEFGHIJKLQRSTU )\n'
    + 'FIELDTYPE:invalid_dfe_mail_us_address:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,spons_dfe_mail_us_address2)\n'
    + 'FIELDTYPE:invalid_dfe_mail_foreign_addr:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,spons_dfe_mail_foreign_addr2)\n'
    + 'FIELDTYPE:invalid_dfe_loc_us_address:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,spons_dfe_loc_us_address2)\n'
    + 'FIELDTYPE:invalid_dfe_loc_foreign_address:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,spons_dfe_loc_foreign_address2)\n'
    + 'FIELDTYPE:invalid_admin_us_address:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,admin_us_address2)\n'
    + 'FIELDTYPE:invalid_admin_foreign_address:CUSTOM(Scrubs_IRS5500.Functions.fn_chk_blanks>0,admin_foreign_address2)\n'
    + 'FIELDTYPE:invalid_alpha_numeric_blank:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ) \n'
    + 'FIELDTYPE:invalid_alphablank:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_alpha_sp:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.-, ) \n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_IRS5500.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_full_zip:CUSTOM(Scrubs_IRS5500.functions.fn_verify_full_zip>0)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_IRS5500.functions.fn_CleanPhone>0)\n'
    + 'FIELDTYPE:invalid_filing_status:ENUM(FILING_ERROR|FILING_RECEIVED|PROCESSING_STOPPED|)\n'
    + '\n'
    + 'FIELD:ack_id:TYPE(STRING30):LIKE(invalid_ack_id):0,0\n'
    + 'FIELD:form_plan_year_begin_date:TYPE(STRING10):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:form_tax_prd:TYPE(STRING10):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:type_plan_entity_cd:TYPE(STRING1):LIKE(invalid_type_plan_entity_cd):0,0\n'
    + 'FIELD:type_dfe_plan_entity_cd:TYPE(STRING1):LIKE(invalid_type_dfe_plan_entity_cd):0,0\n'
    + 'FIELD:initial_filing_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:amended_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:final_filing_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:short_plan_yr_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:collective_bargain_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:f5558_application_filed_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:ext_automatic_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:dfvc_program_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:ext_special_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:ext_special_text:TYPE(STRING35):0,0\n'
    + 'FIELD:plan_name:TYPE(STRING140):LIKE(invalid_name):0,0\n'
    + 'FIELD:spons_dfe_pn:TYPE(STRING3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:plan_eff_date:TYPE(STRING10):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:sponsor_dfe_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:spons_dfe_dba_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:spons_dfe_care_of_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:spons_dfe_mail_us_address1:TYPE(STRING35):LIKE(invalid_dfe_mail_us_address):0,0\n'
    + 'FIELD:spons_dfe_mail_us_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:spons_dfe_mail_us_city:TYPE(STRING22):LIKE(invalid_alpha_sp):0,0\n'
    + 'FIELD:spons_dfe_mail_us_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:spons_dfe_mail_us_zip:TYPE(STRING12):LIKE(invalid_full_zip):0,0\n'
    + 'FIELD:spons_dfe_mail_foreign_addr1:TYPE(STRING35):LIKE(invalid_dfe_mail_foreign_addr):0,0\n'
    + 'FIELD:spons_dfe_mail_foreign_addr2:TYPE(STRING35):0,0\n'
    + 'FIELD:spons_dfe_mail_foreign_city:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_mail_forgn_prov_st:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_mail_foreign_cntry:TYPE(STRING2):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_mail_forgn_postal_cd:TYPE(STRING22):LIKE(invalid_alpha_numeric_blank):0,0\n'
    + 'FIELD:spons_dfe_loc_us_address1:TYPE(STRING35):LIKE(invalid_dfe_loc_us_address):0,0\n'
    + 'FIELD:spons_dfe_loc_us_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:spons_dfe_loc_us_city:TYPE(STRING22):LIKE(invalid_alpha_sp):0,0\n'
    + 'FIELD:spons_dfe_loc_us_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:spons_dfe_loc_us_zip:TYPE(STRING12):LIKE(invalid_full_zip):0,0\n'
    + 'FIELD:spons_dfe_loc_foreign_address1:TYPE(STRING35):LIKE(invalid_dfe_loc_foreign_address):0,0\n'
    + 'FIELD:spons_dfe_loc_foreign_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:spons_dfe_loc_foreign_city:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_loc_forgn_prov_st:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_loc_foreign_cntry:TYPE(STRING2):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:spons_dfe_loc_forgn_postal_cd:TYPE(STRING22):LIKE(invalid_alpha_numeric_blank):0,0\n'
    + 'FIELD:spons_dfe_ein:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:spons_dfe_phone_num:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:business_code:TYPE(STRING6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:admin_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:admin_care_of_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:admin_us_address1:TYPE(STRING35):LIKE(invalid_admin_us_address):0,0\n'
    + 'FIELD:admin_us_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:admin_us_city:TYPE(STRING22):LIKE(invalid_alpha_sp):0,0\n'
    + 'FIELD:admin_us_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:admin_us_zip:TYPE(STRING12):LIKE(invalid_full_zip):0,0\n'
    + 'FIELD:admin_foreign_address1:TYPE(STRING35):LIKE(invalid_admin_foreign_address):0,0\n'
    + 'FIELD:admin_foreign_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:admin_foreign_city:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:admin_foreign_prov_state:TYPE(STRING22):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:admin_foreign_cntry:TYPE(STRING2):LIKE(invalid_alphablank):0,0\n'
    + 'FIELD:admin_foreign_postal_cd:TYPE(STRING22):LIKE(invalid_alpha_numeric_blank):0,0\n'
    + 'FIELD:admin_ein:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:admin_phone_num:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:last_rpt_spons_name:TYPE(STRING70):LIKE(invalid_name):0,0\n'
    + 'FIELD:last_rpt_spons_ein:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:last_rpt_plan_num:TYPE(STRING3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:admin_signed_date:TYPE(STRING30):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:admin_signed_name:TYPE(STRING35):LIKE(invalid_name):0,0\n'
    + 'FIELD:spons_signed_date:TYPE(STRING30):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:spons_signed_name:TYPE(STRING35):LIKE(invalid_name):0,0\n'
    + 'FIELD:dfe_signed_date:TYPE(STRING30):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dfe_signed_name:TYPE(STRING35):LIKE(invalid_name):0,0\n'
    + 'FIELD:tot_partcp_boy_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:tot_active_partcp_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:rtd_sep_partcp_rcvg_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:rtd_sep_partcp_fut_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:subtl_act_rtd_sep_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:benef_rcvg_bnft_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:tot_act_rtd_sep_benef_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:partcp_account_bal_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:sep_partcp_partl_vstd_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:contrib_emplrs_cnt:TYPE(STRING8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:type_pension_bnft_code:TYPE(STRING40):LIKE(invalid_type_pension_bnft_code):0,0\n'
    + 'FIELD:type_welfare_bnft_code:TYPE(STRING40):LIKE(invalid_type_welfare_bnft_code):0,0\n'
    + 'FIELD:funding_insurance_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:funding_sec412_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:funding_trust_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:funding_gen_asset_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:benefit_insurance_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:benefit_sec412_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:benefit_trust_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:benefit_gen_asset_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_r_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_mb_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_sb_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_h_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_i_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_a_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:num_sch_a_attached_cnt:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:sch_c_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_d_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:sch_g_attached_ind:TYPE(STRING1):LIKE(invalid_zero_1_bk):0,0\n'
    + 'FIELD:filing_status:TYPE(STRING50):LIKE(invalid_filing_status):0,0\n'
    + 'FIELD:date_received:TYPE(STRING10):LIKE(invalid_generaldate):0,0\n'
    + 'FIELD:valid_admin_signature:TYPE(STRING54):0,0\n'
    + 'FIELD:valid_dfe_signature:TYPE(STRING54):0,0\n'
    + 'FIELD:valid_sponsor_signature:TYPE(STRING54):0,0\n'
    + 'FIELD:admin_phone_num_foreign:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:spons_dfe_phone_num_foreign:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:admin_name_same_spon_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:admin_address_same_spon_ind:TYPE(STRING1):0,0\n'
    + 'FIELD:preparer_name:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_firm_name:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_us_address1:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_us_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_us_city:TYPE(STRING22):0,0\n'
    + 'FIELD:preparer_us_state:TYPE(STRING2):0,0\n'
    + 'FIELD:preparer_us_zip:TYPE(STRING12):0,0\n'
    + 'FIELD:preparer_foreign_address1:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_foreign_address2:TYPE(STRING35):0,0\n'
    + 'FIELD:preparer_foreign_city:TYPE(STRING22):0,0\n'
    + 'FIELD:preparer_foreign_prov_state:TYPE(STRING22):0,0\n'
    + 'FIELD:preparer_foreign_cntry:TYPE(STRING2):0,0\n'
    + 'FIELD:preparer_foreign_postal_cd:TYPE(STRING22):0,0\n'
    + 'FIELD:preparer_phone_num:TYPE(STRING10):0,0\n'
    + 'FIELD:preparer_phone_num_foreign:TYPE(STRING30):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

