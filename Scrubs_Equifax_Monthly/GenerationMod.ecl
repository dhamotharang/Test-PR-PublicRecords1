// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Equifax_Monthly \n'
    + 'FILENAME:File\n'
    + '\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking \n'
    + '\n'
    + 'FIELDTYPE:base:SPACES( ):LEFTTRIM:ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:az:LIKE(base):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:nm:LIKE(base):ALLOW(0123456789)\n'
    + 'FIELDTYPE:aznm:LIKE(base):ALLOW( #0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ) \n'
    + 'FIELDTYPE:a_name:LIKE(base):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..13):WORDS(1..4)\n'
    + '\n'
    + 'FIELDTYPE:first_name:LIKE(a_name):LENGTHS(3..11):WORDS(1..1)\n'
    + 'FIELDTYPE:middle_initial:LIKE(a_name):LENGTHS(1..1):WORDS(0..1)\n'
    + 'FIELDTYPE:last_name:LIKE(a_name):LENGTHS(3..11):WORDS(1..1)\n'
    + 'FIELDTYPE:suffix:LIKE(a_name):ALLOW(1234567JRS):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_first_name:LIKE(first_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_middle_initial:LIKE(middle_initial):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_last_name:LIKE(last_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_suffix:LIKE(suffix):LENGTHS(0):WORDS(0)\n'
    + 'FIELDTYPE:former_first_name2:LIKE(former_first_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_middle_initial2:LIKE(former_middle_initial):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_last_name2:LIKE(former_last_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:former_suffix2:LIKE(former_suffix):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:aka_first_name:LIKE(a_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:aka_middle_initial:LIKE(middle_initial):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:aka_last_name:LIKE(last_name):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:aka_suffix:LIKE(suffix):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:current_address:LIKE(aznm):LENGTHS(10..30):WORDS(1..6)\n'
    + 'FIELDTYPE:current_city:LIKE(az):LENGTHS(4..16):WORDS(1..3)\n'
    + 'FIELDTYPE:current_state:LIKE(az):LENGTHS(2):WORDS(1)\n'
    + 'FIELDTYPE:current_zip:LIKE(nm):LENGTHS(5):WORDS(1)\n'
    + 'FIELDTYPE:current_address_date_reported:LIKE(nm):LENGTHS(6):WORDS(1)\n'
    + 'FIELDTYPE:former1_address:LIKE(current_address)\n'
    + 'FIELDTYPE:former1_city:LIKE(current_city)\n'
    + 'FIELDTYPE:former1_state:LIKE(current_state)\n'
    + 'FIELDTYPE:former1_zip:LIKE(current_zip)\n'
    + 'FIELDTYPE:former1_address_date_reported:LIKE(current_address_date_reported)\n'
    + 'FIELDTYPE:former2_address:LIKE(current_address)\n'
    + 'FIELDTYPE:former2_city:LIKE(current_city)\n'
    + 'FIELDTYPE:former2_state:LIKE(current_state)\n'
    + 'FIELDTYPE:former2_zip:LIKE(current_zip)\n'
    + 'FIELDTYPE:former2_address_date_reported:LIKE(current_address_date_reported)\n'
    + 'FIELDTYPE:blank1:LIKE(nm):LENGTHS(4):WORDS(1)\n'
    + 'FIELDTYPE:valid_ssn:LIKE(nm):LENGTHS(9):WORDS(1):CUSTOM(fn_valid_ssn)\n'
    + 'FIELDTYPE:cid:LIKE(base):ALLOW(0123456789ABCDEF):LENGTHS(9):WORDS(1)\n'
    + 'FIELDTYPE:ssn_confirmed:LIKE(base):ALLOW(C):LENGTHS(1):WORDS(1)\n'
    + 'FIELDTYPE:blank2:LIKE(base):LENGTHS(0):WORDS(0..1)\n'
    + 'FIELDTYPE:blank3:LIKE(nm):LENGTHS(0):WORDS(0..1)\n'
    + '\n'
    + 'FIELD:first_name:LIKE(first_name):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:middle_initial:LIKE(middle_initial):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:last_name:LIKE(last_name):TYPE(EBCDIC STRING25):0,0\n'
    + 'FIELD:suffix:LIKE(suffix):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:former_first_name:LIKE(former_first_name):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:former_middle_initial:LIKE(former_middle_initial):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:former_last_name:LIKE(former_last_name):TYPE(EBCDIC STRING25):0,0\n'
    + 'FIELD:former_suffix:LIKE(former_suffix):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:former_first_name2:LIKE(former_first_name2):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:former_middle_initial2:LIKE(former_middle_initial2):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:former_last_name2:LIKE(former_last_name2):TYPE(EBCDIC STRING25):0,0\n'
    + 'FIELD:former_suffix2:LIKE(former_suffix2):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:aka_first_name:LIKE(aka_first_name):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:aka_middle_initial:LIKE(aka_middle_initial):TYPE(EBCDIC STRING15):0,0\n'
    + 'FIELD:aka_last_name:LIKE(aka_last_name):TYPE(EBCDIC STRING25):0,0\n'
    + 'FIELD:aka_suffix:LIKE(aka_suffix):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:current_address:LIKE(current_address):TYPE(EBCDIC STRING57):0,0\n'
    + 'FIELD:current_city:LIKE(current_city):TYPE(EBCDIC STRING20):0,0\n'
    + 'FIELD:current_state:LIKE(current_state):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:current_zip:LIKE(current_zip):TYPE(EBCDIC STRING5):0,0\n'
    + 'FIELD:current_address_date_reported:LIKE(current_address_date_reported):TYPE(EBCDIC STRING6):0,0\n'
    + 'FIELD:former1_address:LIKE(former1_address):TYPE(EBCDIC STRING57):0,0\n'
    + 'FIELD:former1_city:LIKE(former1_city):TYPE(EBCDIC STRING20):0,0\n'
    + 'FIELD:former1_state:LIKE(former1_state):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:former1_zip:LIKE(former1_zip):TYPE(EBCDIC STRING5):0,0\n'
    + 'FIELD:former1_address_date_reported:LIKE(former1_address_date_reported):TYPE(EBCDIC STRING6):0,0\n'
    + 'FIELD:former2_address:LIKE(former2_address):TYPE(EBCDIC STRING57):0,0\n'
    + 'FIELD:former2_city:LIKE(former2_city):TYPE(EBCDIC STRING20):0,0\n'
    + 'FIELD:former2_state:LIKE(former2_state):TYPE(EBCDIC STRING2):0,0\n'
    + 'FIELD:former2_zip:LIKE(former2_zip):TYPE(EBCDIC STRING5):0,0\n'
    + 'FIELD:former2_address_date_reported:LIKE(former2_address_date_reported):TYPE(EBCDIC STRING6):0,0\n'
    + 'FIELD:blank1:LIKE(blank1):TYPE(EBCDIC STRING6):0,0\n'
    + 'FIELD:ssn:LIKE(valid_ssn):TYPE(EBCDIC STRING9):0,0\n'
    + 'FIELD:cid:LIKE(cid):TYPE(EBCDIC STRING9):0,0\n'
    + 'FIELD:ssn_confirmed:LIKE(ssn_confirmed):TYPE(EBCDIC STRING1):0,0\n'
    + 'FIELD:blank2:LIKE(blank2):TYPE(EBCDIC STRING1):0,0\n'
    + 'FIELD:blank3:LIKE(blank3):TYPE(EBCDIC STRING43):0,0\n'
    + '\n'
    + 'RECORDTYPE:ssn_confirmed_is_valid:TAG(ssn_confirmed,\'C\'):VALID(ssn)\n'
    + '\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
