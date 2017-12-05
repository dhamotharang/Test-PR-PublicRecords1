﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_ALC_PHARMACISTS\n'
    + 'FILENAME:ALC_PHARMACISTS\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + 'FIELDTYPE:invalid_slash_date:ALLOW(/0123456789)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_alphapound:ALLOW(#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_alphaspace:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_alphaspacequote:ALLOW( \'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:invalid_gender:ENUM(M|F|B|I|U| )\n'
    + 'FIELDTYPE:invalid_addr_type:ALLOW(#BCHLPUXY)\n'
    + 'FIELDTYPE:invalid_license_number:ALLOW( .-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELD:fname:TYPE(STRING25):LIKE(invalid_alphaspacequote):0,0\n'
    + 'FIELD:lname:TYPE(STRING35):LIKE(invalid_alphaspacequote):0,0\n'
    + 'FIELD:title:TYPE(STRING40):LIKE(invalid_alphaspace):0,0\n'
    + 'FIELD:company:TYPE(STRING60):0,0\n'
    + 'FIELD:address1:TYPE(STRING40):0,0\n'
    + 'FIELD:address2:TYPE(STRING40):0,0\n'
    + 'FIELD:city:TYPE(STRING25):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:bar:TYPE(STRING3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0\n'
    + 'FIELD:country:TYPE(STRING22):0,0\n'
    + 'FIELD:postal_cd:TYPE(STRING20):0,0\n'
    + 'FIELD:dpv:TYPE(STRING1):0,0\n'
    + 'FIELD:addr_type:TYPE(STRING15):LIKE(invalid_addr_type):0,0\n'
    + 'FIELD:age:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:county_cd:TYPE(STRING15):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:orig_date:TYPE(STRING15):LIKE(invalid_slash_date):0,0\n'
    + 'FIELD:exp_date:TYPE(STRING30):LIKE(invalid_slash_date):0,0\n'
    + 'FIELD:fax:TYPE(STRING1):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:license_state:TYPE(STRING50):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:license_type:TYPE(STRING30):LIKE(invalid_alphapound):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:nielsen_county_cd:TYPE(STRING1):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:email:TYPE(STRING132):0,0\n'
    + 'FIELD:list_id:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:scno:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:keycode:TYPE(STRING35):0,0\n'
    + 'FIELD:custno:TYPE(STRING16):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:license_no:TYPE(STRING20):LIKE(invalid_license_number):0,0\n'
    + 'FIELD:dob:TYPE(STRING20):LIKE(invalid_date):0,0\n'
    + 'FIELD:degree:TYPE(STRING20):0,0\n'
    + 'FIELD:specialty:TYPE(STRING20):0,0\n'
    + 'FIELD:phone:TYPE(STRING20):LIKE(invalid_numeric):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
