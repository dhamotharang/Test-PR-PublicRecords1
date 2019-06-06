// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_BKForeclosure_Nod';
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
  EXPORT spc_FILENAME := 'BKForeclosure_Nod';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,foreclosure_id,ln_filedate,bk_infile_type,src_county,src_state,fips_cd,doc_type,recording_dt,recording_doc_num,book_number,page_number,loan_number,trustee_sale_number,case_number,orig_contract_date,unpaid_balance,past_due_amt,as_of_dt,contact_fname,contact_lname,attention_to,contact_mail_full_addr,contact_mail_unit,contact_mail_city,contact_mail_state,contact_mail_zip5,contact_mail_zip4,contact_telephone,due_date,trustee_fname,trustee_lname,trustee_mail_full_addr,trustee_mail_unit,trustee_mail_city,trustee_mail_state,trustee_mail_zip5,trustee_mail_zip4,trustee_telephone,borrower1_fname,borrower1_lname,borrower1_id_cd,borrower2_fname,borrower2_lname,borrower2_id_cd,orig_lender_name,orig_lender_type,curr_lender_name,curr_lender_type,mers_indicator,loan_recording_date,loan_doc_num,loan_book,loan_page,orig_loan_amt,legal_lot_num,legal_block,legal_subdivision_name,legal_brief_desc,auction_date,auction_time,auction_location,auction_min_bid_amt,trustee_mail_careof,property_addr_cd,auction_city,original_nod_recording_date,original_nod_doc_num,original_nod_book,original_nod_page,nod_apn,property_full_addr,prop_addr_unit_type,prop_addr_unit_no,prop_addr_city,prop_addr_state,prop_addr_zip5,prop_addr_zip4,apn,sam_pid,deed_pid,lps_internal_pid,nod_source';
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
    + 'MODULE:Scrubs_BKForeclosure_Nod\n'
    + 'FILENAME:BKForeclosure_Nod\n'
    + '\n'
    + 'FIELDTYPE:invalid_number:ALLOW(0123456789):\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( <>{}[]-^=!+&,()#.;/)\n'
    + 'FIELDTYPE:invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( -.)\n'
    + 'FIELDTYPE:invalid_apn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( ()-,;\'=&_.\\/:+#*)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,4,5)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0,4,8,10)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789):LENGTHS(0,7,10)\n'
    + 'FIELDTYPE:invalid_amount:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_mers:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_document_code:CUSTOM(Scrubs_BKForeclosure_Nod.fn_valid_codes > 0,\'B7\',\'DOCUMENT_TYPE\') \n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):LENGTHS(0,2) \n'
    + 'FIELDTYPE:invalid_case:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( {}-&,.():+#/)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\'):SPACES( -&,.():\'#+;"\\/*@)\n'
    + 'FIELDTYPE:Invalid_NodSourceCode:ENUM(P|S)\n'
    + '\n'
    + 'FIELD:foreclosure_id:TYPE(STRING70):0,0\n'
    + 'FIELD:ln_filedate:LIKE(invalid_date):0,0\n'
    + 'FIELD:bk_infile_type:TYPE(STRING30):0,0\n'
    + 'FIELD:src_county:TYPE(STRING35):0,0\n'
    + 'FIELD:src_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:fips_cd:LIKE(invalid_number):0,0\n'
    + 'FIELD:doc_type:LIKE(invalid_document_code):0,0\n'
    + 'FIELD:recording_dt:LIKE(invalid_date):0,0\n'
    + 'FIELD:recording_doc_num:TYPE(STRING20):0,0\n'
    + 'FIELD:book_number:TYPE(STRING10):0,0\n'
    + 'FIELD:page_number:TYPE(STRING10):0,0\n'
    + 'FIELD:loan_number:TYPE(STRING30):0,0\n'
    + 'FIELD:trustee_sale_number:TYPE(STRING15):0,0\n'
    + 'FIELD:case_number:LIKE(invalid_case):0,0\n'
    + 'FIELD:orig_contract_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:unpaid_balance:TYPE(STRING9):0,0\n'
    + 'FIELD:past_due_amt:TYPE(STRING9):0,0\n'
    + 'FIELD:as_of_dt:LIKE(invalid_date):0,0\n'
    + 'FIELD:contact_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:contact_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:attention_to:TYPE(STRING40):0,0\n'
    + 'FIELD:contact_mail_full_addr:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:contact_mail_unit:TYPE(STRING11):0,0\n'
    + 'FIELD:contact_mail_city:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:contact_mail_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:contact_mail_zip5:LIKE(invalid_zip):0,0\n'
    + 'FIELD:contact_mail_zip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:contact_telephone:TYPE(STRING14):0,0\n'
    + 'FIELD:due_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:trustee_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:trustee_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:trustee_mail_full_addr:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:trustee_mail_unit:TYPE(STRING11):0,0\n'
    + 'FIELD:trustee_mail_city:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:trustee_mail_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:trustee_mail_zip5:LIKE(invalid_zip):0,0\n'
    + 'FIELD:trustee_mail_zip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:trustee_telephone:TYPE(STRING12):0,0\n'
    + 'FIELD:borrower1_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:borrower1_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:borrower1_id_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:borrower2_fname:LIKE(invalid_name):0,0\n'
    + 'FIELD:borrower2_lname:LIKE(invalid_name):0,0\n'
    + 'FIELD:borrower2_id_cd:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_lender_name:LIKE(invalid_name):0,0\n'
    + 'FIELD:orig_lender_type:TYPE(STRING1):0,0\n'
    + 'FIELD:curr_lender_name:TYPE(STRING40):0,0\n'
    + 'FIELD:curr_lender_type:TYPE(STRING1):0,0\n'
    + 'FIELD:mers_indicator:LIKE(invalid_mers):0,0\n'
    + 'FIELD:loan_recording_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:loan_doc_num:TYPE(STRING20):0,0\n'
    + 'FIELD:loan_book:TYPE(STRING10):0,0\n'
    + 'FIELD:loan_page:TYPE(STRING10):0,0\n'
    + 'FIELD:orig_loan_amt:LIKE(invalid_amount):0,0\n'
    + 'FIELD:legal_lot_num:TYPE(STRING10):0,0\n'
    + 'FIELD:legal_block:TYPE(STRING7):0,0\n'
    + 'FIELD:legal_subdivision_name:LIKE(invalid_name):0,0\n'
    + 'FIELD:legal_brief_desc:TYPE(STRING100):0,0\n'
    + 'FIELD:auction_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:auction_time:TYPE(STRING5):0,0\n'
    + 'FIELD:auction_location:TYPE(STRING60):0,0\n'
    + 'FIELD:auction_min_bid_amt:TYPE(STRING11):0,0\n'
    + 'FIELD:trustee_mail_careof:TYPE(STRING40):0,0\n'
    + 'FIELD:property_addr_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:auction_city:TYPE(STRING30):0,0\n'
    + 'FIELD:original_nod_recording_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:original_nod_doc_num:TYPE(STRING20):0,0\n'
    + 'FIELD:original_nod_book:TYPE(STRING10):0,0\n'
    + 'FIELD:original_nod_page:TYPE(STRING10):0,0\n'
    + 'FIELD:nod_apn:LIKE(invalid_apn):0,0\n'
    + 'FIELD:property_full_addr:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:prop_addr_unit_type:TYPE(STRING4):0,0\n'
    + 'FIELD:prop_addr_unit_no:TYPE(STRING11):0,0\n'
    + 'FIELD:prop_addr_city:LIKE(invalid_AlphaNum):0,0\n'
    + 'FIELD:prop_addr_state:LIKE(invalid_state):0,0\n'
    + 'FIELD:prop_addr_zip5:LIKE(invalid_zip):0,0\n'
    + 'FIELD:prop_addr_zip4:LIKE(invalid_zip):0,0\n'
    + 'FIELD:apn:LIKE(invalid_apn):0,0\n'
    + 'FIELD:sam_pid:TYPE(STRING10):0,0\n'
    + 'FIELD:deed_pid:TYPE(STRING10):0,0\n'
    + 'FIELD:lps_internal_pid:TYPE(STRING10):0,0\n'
    + 'FIELD:nod_source:LIKE(Invalid_NodSourceCode):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

