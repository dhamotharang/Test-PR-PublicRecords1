﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT input_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_American_Student_List';
  EXPORT spc_NAMESCOPE := 'input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_American_Student_List\n'
    + 'FILENAME:American_Student_List\n'
    + 'NAMESCOPE:input \n'
    + '\n'
    + 'FIELDTYPE:invalid_nums:ALLOW(0123456789):SPACES( )\n'
    + 'FIELDTYPE:invalid_gender_code:ENUM(1|2|M|F|U|)\n'
    + 'FIELDTYPE:invalid_alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_address:SPACES( ):ALLOW(\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -):WORDS(1,2,3,4,5)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)\n'
    + 'FIELDTYPE:invalid_college_class:ENUM(FR|GR|JR|SO|SR|UN|)\n'
    + 'FIELDTYPE:invalid_college_code:ENUM(1|2|4|)\n'
    + 'FIELDTYPE:invalid_college_type:ENUM(N|P|R|S|)    \n'
    + 'FIELDTYPE:invalid_income_lvl_code:ENUM(A|B|C|D|E|F|G|H|I|J|K|T|L|M|N|O|)\n'
    + 'FIELDTYPE:invalid_income:ALLOW($,+-0123456789OVER):SPACES( )\n'
    + 'FIELDTYPE:invalid_file_type:ENUM(M|C|H)\n'
    + 'FIELDTYPE:invalid_major:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELD:name:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:first_name:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:last_name:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:address_1:TYPE(STRING):LIKE(invalid_address):0,0\n'
    + 'FIELD:address_2:TYPE(STRING):LIKE(invalid_address):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING):0,0\n'
    + 'FIELD:z5:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:zip_4:TYPE(STRING):0,0\n'
    + 'FIELD:crrt_code:TYPE(STRING):0,0\n'
    + 'FIELD:delivery_point_barcode:TYPE(STRING):0,0\n'
    + 'FIELD:zip4_check_digit:TYPE(STRING):0,0\n'
    + 'FIELD:address_type:TYPE(STRING):0,0\n'
    + 'FIELD:county_number:TYPE(STRING):LIKE(invalid_nums):0,0\n'
    + 'FIELD:county_name:TYPE(STRING):LIKE(invalid_county_name):0,0\n'
    + 'FIELD:gender:TYPE(STRING):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:age:TYPE(STRING):LIKE(invalid_nums):0,0\n'
    + 'FIELD:birth_date:TYPE(STRING):LIKE(invalid_nums):0,0\n'
    + 'FIELD:telephone:TYPE(STRING):LIKE(invalid_nums):0,0\n'
    + 'FIELD:class:TYPE(STRING):0,0\n'
    + 'FIELD:college_class:TYPE(STRING):LIKE(invalid_college_class):0,0\n'
    + 'FIELD:college_name:TYPE(STRING):0,0\n'
    + 'FIELD:college_major:TYPE(STRING):LIKE(invalid_major):0,0\n'
    + 'FIELD:college_code:TYPE(STRING):LIKE(invalid_college_code):0,0\n'
    + 'FIELD:college_type:TYPE(STRING):LIKE(invalid_college_type):0,0\n'
    + 'FIELD:head_of_household_first_name:TYPE(STRING):0,0\n'
    + 'FIELD:head_of_household_gender:TYPE(STRING):LIKE(invalid_gender_code):0,0\n'
    + 'FIELD:income_level:TYPE(STRING):LIKE(invalid_income_lvl_code):0,0\n'
    + 'FIELD:file_type:TYPE(STRING):LIKE(invalid_file_type):0,0\t\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
