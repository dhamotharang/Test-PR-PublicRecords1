// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inquiry_History';
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
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,lex_id,product_id,inquiry_date,transaction_id,date_added,customer_number,customer_account,ssn,drivers_license_number,drivers_license_state,name_first,name_last,name_middle,name_suffix,addr_street,addr_city,addr_state,addr_zip5,addr_zip4,dob,transaction_location,ppc,internal_identifier,eu1_customer_number,eu1_customer_account,eu2_customer_number,eu2_customer_account,email_addr,ip_address,state_id_number,state_id_state,eu_company_name,eu_addr_street,eu_addr_city,eu_addr_state,eu_addr_zip5,eu_phone_nbr,product_code,transaction_type,function_name,customer_id,company_id,global_company_id,phone_nbr';
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
    + 'MODULE:Scrubs_Inquiry_History\n'
    + 'FILENAME:File\n'
    + ' \n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$;):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:lex_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(12,10,9,11,8,7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:product_id:SPACES( ):ALLOW(12):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:inquiry_date:SPACES( ):ALLOW( -0123456789:):LEFTTRIM:LENGTHS(19):WORDS(2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:transaction_id:SPACES( ):ALLOW(0123456789R):LEFTTRIM:LENGTHS(16,15):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_added:SPACES( ):ALLOW( -0123456789:):LEFTTRIM:LENGTHS(19):WORDS(2):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELDTYPE:customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ssn:SPACES( ):LEFTTRIM:LENGTHS(9,4,2):WORDS(1):ONFAIL(CLEAN) \n'
    + 'FIELDTYPE:drivers_license_number:SPACES( ):LEFTTRIM:LENGTHS(2,8,9,13,10,7,12,15,14,11,17,6):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:drivers_license_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_first:SPACES( ):LEFTTRIM:LENGTHS(6,7,5,4,8,9,3,11,10,2,1,12,13,15,14):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_last:SPACES( ):LEFTTRIM:LENGTHS(6,5,7,8,4,9,10,3,11,12,2,13,14,15,16,17,1,18):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_middle:SPACES( ):LEFTTRIM:LENGTHS(2,1,6,7,5,4,8,9,3):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_suffix:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_street:SPACES( ):LEFTTRIM:LENGTHS(0,15,16,17,14,18,13,19,20,12,21,22,23,11,24,25,10,26,27,9,28,8,6,7,4,29,5,30,31,3,32,33,34,35,36,38,37,2,39,1,40,41,43):WORDS(3,4,0,5,1,6,2,7,8):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_city:SPACES( ):LEFTTRIM:LENGTHS(2,7,9,8,6,10,11,12,5,13,14,4,15,16,17,18,3,19):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_zip5:SPACES( ):LEFTTRIM:LENGTHS(5,2,4):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_zip4:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dob:SPACES( ):LEFTTRIM:LENGTHS(10,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:transaction_location:SPACES( ):LEFTTRIM:LENGTHS(13,8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ppc:SPACES( ):LEFTTRIM:LENGTHS(3,1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:internal_identifier:SPACES( ):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu1_customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu1_customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu2_customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu2_customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:email_addr:SPACES( ):LEFTTRIM:LENGTHS(2,20,19,18):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ip_address:SPACES( ):LEFTTRIM:LENGTHS(2,13,14,12,39,38):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:state_id_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:state_id_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_company_name:SPACES( ):LEFTTRIM:LENGTHS(2,13,6,10,27,15,7,3,9,11,19,23,17,26,22,37,24,29,16,8,38,12,5,28,32,21,34,41,30,20,45,40,31,14,36,25,35,18,33):WORDS(1,2,4,3,5,6,8,7):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_addr_street:SPACES( ):LEFTTRIM:LENGTHS(2,20,17,13,19,16,29,22,30,14,21,18,28,24,5,10,15,26,11,23,25,12,0,9,27,36):WORDS(1,4,3,5,6,2,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_addr_city:SPACES( ):LEFTTRIM:LENGTHS(2,7,9,10,8,12,6,13,11,15,5,14,4):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_addr_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_addr_zip5:SPACES( ):LEFTTRIM:LENGTHS(2,5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:eu_phone_nbr:SPACES( ):LEFTTRIM:LENGTHS(2,10):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:product_code:SPACES( ):LEFTTRIM:LENGTHS(3):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:transaction_type:SPACES( ):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:function_name:SPACES( ):LEFTTRIM:LENGTHS(16,9,11,13):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:customer_id:SPACES( ):LEFTTRIM:LENGTHS(11,12,8,10,9,13,14,16,7,15,18,17):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:company_id:SPACES( ):LEFTTRIM:LENGTHS(6,7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:global_company_id:SPACES( ):LEFTTRIM:LENGTHS(7,5,8,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:phone_nbr:SPACES( ):LEFTTRIM:LENGTHS(10,2):WORDS(1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:lex_id:LIKE(NUMBER):TYPE(STRING30):0,0\n'
    + 'FIELD:product_id:TYPE(STRING30):0,0\n'
    + 'FIELD:inquiry_date:TYPE(STRING22):0,0\n'
    + 'FIELD:transaction_id:TYPE(STRING20):0,0\n'
    + 'FIELD:date_added:TYPE(STRING22):0,0\n'
    + 'FIELD:customer_number:TYPE(STRING5):0,0\n'
    + 'FIELD:customer_account:TYPE(STRING9):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:drivers_license_number:TYPE(STRING25):0,0\n'
    + 'FIELD:drivers_license_state:TYPE(STRING2):0,0\n'
    + 'FIELD:name_first:TYPE(STRING20):0,0\n'
    + 'FIELD:name_last:TYPE(STRING20):0,0\n'
    + 'FIELD:name_middle:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING20):0,0\n'
    + 'FIELD:addr_street:TYPE(STRING90):0,0\n'
    + 'FIELD:addr_city:TYPE(STRING25):0,0\n'
    + 'FIELD:addr_state:TYPE(STRING2):0,0\n'
    + 'FIELD:addr_zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:addr_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:dob:TYPE(STRING22):0,0\n'
    + 'FIELD:transaction_location:TYPE(STRING20):0,0\n'
    + 'FIELD:ppc:TYPE(STRING3):0,0\n'
    + 'FIELD:internal_identifier:TYPE(STRING1):0,0\n'
    + 'FIELD:eu1_customer_number:TYPE(STRING5):0,0\n'
    + 'FIELD:eu1_customer_account:TYPE(STRING9):0,0\n'
    + 'FIELD:eu2_customer_number:TYPE(STRING5):0,0\n'
    + 'FIELD:eu2_customer_account:TYPE(STRING9):0,0\n'
    + 'FIELD:email_addr:TYPE(STRING):0,0\n'
    + 'FIELD:ip_address:TYPE(STRING):0,0\n'
    + 'FIELD:state_id_number:TYPE(STRING):0,0\n'
    + 'FIELD:state_id_state:TYPE(STRING):0,0\n'
    + 'FIELD:eu_company_name:TYPE(STRING120):0,0\n'
    + 'FIELD:eu_addr_street:TYPE(STRING90):0,0 \n'
    + 'FIELD:eu_addr_city:TYPE(STRING25):0,0\n'
    + 'FIELD:eu_addr_state:TYPE(STRING2):0,0\n'
    + 'FIELD:eu_addr_zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:eu_phone_nbr:TYPE(STRING10):0,0\n'
    + 'FIELD:product_code:TYPE(STRING30):0,0\n'
    + 'FIELD:transaction_type:TYPE(STRING1):0,0\n'
    + 'FIELD:function_name:TYPE(STRING30):0,0\n'
    + 'FIELD:customer_id:TYPE(STRING20):0,0\n'
    + 'FIELD:company_id:TYPE(STRING20):0,0\n'
    + 'FIELD:global_company_id:TYPE(STRING20):0,0\n'
    + 'FIELD:phone_nbr:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

