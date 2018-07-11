// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Document_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Official_Records';
  EXPORT spc_NAMESCOPE := 'Document';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Official_Records';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,vendor,state_origin,county_name,official_record_key,fips_st,fips_county,batch_id,doc_serial_num,doc_instrument_or_clerk_filing_num,doc_num_dummy_flag,doc_filed_dt,doc_record_dt,doc_type_cd,doc_type_desc,doc_other_desc,doc_page_count,doc_names_count,doc_status_cd,doc_status_desc,doc_amend_cd,doc_amend_desc,execution_dt,consideration_amt,assumption_amt,certified_mail_fee,service_charge,trust_amt,transfer_,mortgage,intangible_tax_amt,intangible_tax_penalty,excise_tax_amt,recording_fee,documentary_stamps_fee,doc_stamps_mtg_fee,book_num,page_num,book_type_cd,book_type_desc,parcel_or_case_num,formatted_parcel_num,legal_desc_1,legal_desc_2,legal_desc_3,legal_desc_4,legal_desc_5,verified_flag,address_1,address_2,address_3,address_4,prior_doc_file_num,prior_doc_type_cd,prior_doc_type_desc,prior_book_num,prior_page_num,prior_book_type_cd,prior_book_type_desc,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat';
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
    + 'MODULE:Scrubs_Official_Records\n'
    + 'FILENAME:Official_Records \n'
    + 'NAMESCOPE:Document \n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_FutureDate:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_State:ENUM(FL|CA)\n'
    + 'FIELDTYPE:Invalid_County:CUSTOM(Scrubs_Official_Records.fnValidCounty>0)\n'
    + 'FIELDTYPE:Invalid_NonBlank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\')\n'
    + '\n'
    + '\n'
    + 'FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:vendor:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:state_origin:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:county_name:LIKE(Invalid_County):TYPE(STRING30):0,0\n'
    + 'FIELD:official_record_key:LIKE(Invalid_NonBlank):TYPE(STRING60):0,0\n'
    + 'FIELD:fips_st:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:batch_id:LIKE(Invalid_Num):TYPE(STRING15):0,0\n'
    + 'FIELD:doc_serial_num:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:doc_instrument_or_clerk_filing_num:LIKE(Invalid_NonBlank):TYPE(STRING25):0,0\n'
    + 'FIELD:doc_num_dummy_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:doc_filed_dt:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:doc_record_dt:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:doc_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:doc_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:doc_other_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:doc_page_count:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:doc_names_count:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:doc_status_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:doc_status_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:doc_amend_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:doc_amend_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:execution_dt:LIKE(Invalid_FutureDate):TYPE(STRING8):0,0\n'
    + 'FIELD:consideration_amt:TYPE(STRING25):0,0\n'
    + 'FIELD:assumption_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:certified_mail_fee:TYPE(STRING10):0,0\n'
    + 'FIELD:service_charge:TYPE(STRING10):0,0\n'
    + 'FIELD:trust_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:transfer_:TYPE(STRING10):0,0\n'
    + 'FIELD:mortgage:TYPE(STRING10):0,0\n'
    + 'FIELD:intangible_tax_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:intangible_tax_penalty:TYPE(STRING10):0,0\n'
    + 'FIELD:excise_tax_amt:TYPE(STRING10):0,0\n'
    + 'FIELD:recording_fee:TYPE(STRING10):0,0\n'
    + 'FIELD:documentary_stamps_fee:TYPE(STRING10):0,0\n'
    + 'FIELD:doc_stamps_mtg_fee:TYPE(STRING10):0,0\n'
    + 'FIELD:book_num:TYPE(STRING10):0,0\n'
    + 'FIELD:page_num:TYPE(STRING10):0,0\n'
    + 'FIELD:book_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:book_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:parcel_or_case_num:TYPE(STRING25):0,0\n'
    + 'FIELD:formatted_parcel_num:TYPE(STRING25):0,0\n'
    + 'FIELD:legal_desc_1:TYPE(STRING60):0,0\n'
    + 'FIELD:legal_desc_2:TYPE(STRING60):0,0\n'
    + 'FIELD:legal_desc_3:TYPE(STRING60):0,0\n'
    + 'FIELD:legal_desc_4:TYPE(STRING60):0,0\n'
    + 'FIELD:legal_desc_5:TYPE(STRING60):0,0\n'
    + 'FIELD:verified_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:address_1:TYPE(STRING60):0,0\n'
    + 'FIELD:address_2:TYPE(STRING60):0,0\n'
    + 'FIELD:address_3:TYPE(STRING60):0,0\n'
    + 'FIELD:address_4:TYPE(STRING60):0,0\n'
    + 'FIELD:prior_doc_file_num:TYPE(STRING25):0,0\n'
    + 'FIELD:prior_doc_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:prior_doc_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:prior_book_num:TYPE(STRING10):0,0\n'
    + 'FIELD:prior_page_num:TYPE(STRING10):0,0\n'
    + 'FIELD:prior_book_type_cd:TYPE(STRING5):0,0\n'
    + 'FIELD:prior_book_type_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

