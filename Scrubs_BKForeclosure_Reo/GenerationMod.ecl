// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_BKForeclosure_Reo';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'BKForeclosure_Reo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,foreclosure_id,ln_filedate,bk_infile_type,fips_cd,prop_full_addr,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,prop_addr_unit_type,prop_addr_unit_no,prop_addr_house_no,prop_addr_predir,prop_addr_street,prop_addr_suffix,prop_addr_postdir,prop_addr_carrier_rt,recording_date,recording_book_num,recording_page_num,recording_doc_num,doc_type_cd,apn,multi_apn,partial_interest_trans,seller1_fname,seller1_lname,seller1_id,seller2_fname,seller2_lname,buyer1_fname,buyer1_lname,buyer1_id_cd,buyer2_fname,buyer2_lname,buyer_vesting_cd,concurrent_doc_num,buyer_mail_city,buyer_mail_state,buyer_mail_zip5,buyer_mail_zip4,legal_lot_cd,legal_lot_num,legal_block,legal_section,legal_district,legal_land_lot,legal_unit,legacl_city,legal_subdivision,legal_phase_num,legal_tract_num,legal_brief_desc,legal_township,recorder_map_ref,prop_buyer_mail_addr_cd,property_use_cd,orig_contract_date,sales_price,sales_price_cd,city_xfer_tax,county_xfer_tax,total_xfer_tax,concurrent_lender_name,concurrent_lender_type,concurrent_loan_amt,concurrent_loan_type,concurrent_type_fin,concurrent_interest_rate,concurrent_due_dt,concurrent_2nd_loan_amt,buyer_mail_full_addr,buyer_mail_unit_type,buyer_mail_unit_no,lps_internal_pid,buyer_mail_careof,title_co_name,legal_desc_cd,adj_rate_rider,adj_rate_index,change_index,rate_change_freq,int_rate_ngt,int_rate_nlt,max_int_rate,int_only_period,fixed_rate_rider,first_chg_dt_yy,first_chg_dt_mmdd,prepayment_rider,prepayment_term,asses_land_use,res_indicator,construction_loan,inter_family,cash_purchase,stand_alone_refi,equity_credit_line,reo_flag,distressedsaleflag';
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
    + 'MODULE:Scrubs_BKForeclosure_Reo\n'
    + 'FILENAME:BKForeclosure_Reo\n'
    + '\n'
    + 'FIELDTYPE:invalid_number:ALLOW(0123456789):\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( )\n'
    + 'FIELDTYPE:invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( -.,)\n'
    + 'FIELDTYPE:invalid_apn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( -,;.:|`~/+#)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0,8,10)\n'
    + 'FIELDTYPE:invalid_addr:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( <>{}[]-^=!+&,.()#/;:!")\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):LENGTHS(0,2)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,1,4,5)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( -,.()[]%;\'*+\\/"&#<>:!)\n'
    + 'FIELDTYPE:invalid_document_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,\'DOCUMENT_TYPE\') \n'
    + 'FIELDTYPE:invalid_property_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,\'PROPERTY_USE\') \n'
    + 'FIELDTYPE:invalid_land_use_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,\'LAND_USE\')\n'
    + 'FIELDTYPE:invalid_lender_type_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,\'LENDER_TYPE\')\n'
    + 'FIELDTYPE:invalid_loan_type_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,\'LOAN_TYPE\')\n'
    + '\n'
    + 'FIELD:foreclosure_id:TYPE(STRING70):0,0\n'
    + 'FIELD:ln_filedate:LIKE(invalid_date):0,0\n'
    + 'FIELD:bk_infile_type:TYPE(STRING30):0,0\n'
    + 'FIELD:fips_cd:LIKE(invalid_number):0,0\n'
    + 'FIELD:prop_full_addr:LIKE(invalid_addr):0,0\n'
    + 'FIELD:prop_addr_city:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:prop_addr_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:prop_addr_zip5:LIKE(invalid_zip):0,0\n'
    + 'FIELD:prop_addr_zip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:prop_addr_unit_type:TYPE(STRING4):0,0\n'
    + 'FIELD:prop_addr_unit_no:TYPE(STRING11):0,0\n'
    + 'FIELD:prop_addr_house_no:TYPE(STRING13):0,0\n'
    + 'FIELD:prop_addr_predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prop_addr_street:TYPE(STRING40):0,0\n'
    + 'FIELD:prop_addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:prop_addr_postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:prop_addr_carrier_rt:TYPE(STRING4):0,0\n'
    + 'FIELD:recording_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:recording_book_num:TYPE(STRING10):0,0\n'
    + 'FIELD:recording_page_num:TYPE(STRING10):0,0\n'
    + 'FIELD:recording_doc_num:TYPE(STRING20):0,0\n'
    + 'FIELD:doc_type_cd:LIKE(invalid_document_code):0,0\n'
    + 'FIELD:apn:LIKE(invalid_apn):0,0\n'
    + 'FIELD:multi_apn:TYPE(STRING1):0,0\n'
    + 'FIELD:partial_interest_trans:TYPE(STRING2):0,0\n'
    + 'FIELD:seller1_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:seller1_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:seller1_id:TYPE(STRING2):0,0\n'
    + 'FIELD:seller2_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:seller2_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:buyer1_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:buyer1_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:buyer1_id_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:buyer2_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:buyer2_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:buyer_vesting_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:concurrent_doc_num:TYPE(STRING19):0,0\n'
    + 'FIELD:buyer_mail_city:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:buyer_mail_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:buyer_mail_zip5:LIKE(invalid_zip):0,0\n'
    + 'FIELD:buyer_mail_zip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:legal_lot_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:legal_lot_num:TYPE(STRING10):0,0\n'
    + 'FIELD:legal_block:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_section:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_district:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_land_lot:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_unit:TYPE(STRING6):0,0\n'
    + 'FIELD:legacl_city:TYPE(STRING30):0,0\n'
    + 'FIELD:legal_subdivision:TYPE(STRING50):0,0\n'
    + 'FIELD:legal_phase_num:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_tract_num:TYPE(STRING10):0,0\n'
    + 'FIELD:legal_brief_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:legal_township:TYPE(STRING30):0,0\n'
    + 'FIELD:recorder_map_ref:TYPE(STRING20):0,0\n'
    + 'FIELD:prop_buyer_mail_addr_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:property_use_cd:LIKE(invalid_property_code):0,0\n'
    + 'FIELD:orig_contract_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:sales_price:TYPE(STRING10):0,0\n'
    + 'FIELD:sales_price_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:city_xfer_tax:TYPE(STRING7):0,0\n'
    + 'FIELD:county_xfer_tax:TYPE(STRING7):0,0\n'
    + 'FIELD:total_xfer_tax:TYPE(STRING7):0,0\n'
    + 'FIELD:concurrent_lender_name:TYPE(STRING40):0,0\n'
    + 'FIELD:concurrent_lender_type:LIKE(invalid_lender_type_code):0,0\n'
    + 'FIELD:concurrent_loan_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:concurrent_loan_type:LIKE(invalid_loan_type_code):0,0\n'
    + 'FIELD:concurrent_type_fin:TYPE(STRING4):0,0\n'
    + 'FIELD:concurrent_interest_rate:TYPE(STRING4):0,0\n'
    + 'FIELD:concurrent_due_dt:LIKE(invalid_date):0,0\n'
    + 'FIELD:concurrent_2nd_loan_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:buyer_mail_full_addr:LIKE(invalid_addr):0,0\n'
    + 'FIELD:buyer_mail_unit_type:TYPE(STRING4):0,0\n'
    + 'FIELD:buyer_mail_unit_no:TYPE(STRING11):0,0\n'
    + 'FIELD:lps_internal_pid:TYPE(STRING10):0,0\n'
    + 'FIELD:buyer_mail_careof:TYPE(STRING40):0,0\n'
    + 'FIELD:title_co_name:TYPE(STRING28):0,0\n'
    + 'FIELD:legal_desc_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:adj_rate_rider:TYPE(STRING1):0,0\n'
    + 'FIELD:adj_rate_index:TYPE(STRING15):0,0\n'
    + 'FIELD:change_index:TYPE(STRING4):0,0\n'
    + 'FIELD:rate_change_freq:TYPE(STRING1):0,0\n'
    + 'FIELD:int_rate_ngt:TYPE(STRING4):0,0\n'
    + 'FIELD:int_rate_nlt:TYPE(STRING4):0,0\n'
    + 'FIELD:max_int_rate:TYPE(STRING4):0,0\n'
    + 'FIELD:int_only_period:TYPE(STRING2):0,0\n'
    + 'FIELD:fixed_rate_rider:TYPE(STRING1):0,0\n'
    + 'FIELD:first_chg_dt_yy:TYPE(STRING2):0,0\n'
    + 'FIELD:first_chg_dt_mmdd:TYPE(STRING4):0,0\n'
    + 'FIELD:prepayment_rider:TYPE(STRING1):0,0\n'
    + 'FIELD:prepayment_term:TYPE(STRING2):0,0\n'
    + 'FIELD:asses_land_use:LIKE(invalid_land_use_code):0,0\n'
    + 'FIELD:res_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:construction_loan:TYPE(STRING1):0,0\n'
    + 'FIELD:inter_family:TYPE(STRING1):0,0\n'
    + 'FIELD:cash_purchase:TYPE(STRING1):0,0\n'
    + 'FIELD:stand_alone_refi:TYPE(STRING1):0,0\n'
    + 'FIELD:equity_credit_line:TYPE(STRING1):0,0\n'
    + 'FIELD:reo_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:distressedsaleflag:TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

