// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Contacts_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Sheila_Greco';
  EXPORT spc_NAMESCOPE := 'Contacts';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Sheila_Greco';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,did,did_score,bdid,bdid_score,raw_aid,ace_aid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,record_type,rawfields_maincontactid,rawfields_maincompanyid,rawfields_active,rawfields_firstname,rawfields_midinital,rawfields_lastname,rawfields_age,rawfields_gender,rawfields_primarytitle,rawfields_titlelevel1,rawfields_primarydept,rawfields_secondtitle,rawfields_titlelevel2,rawfields_seconddept,rawfields_thirdtitle,rawfields_titlelevel3,rawfields_thirddept,rawfields_skillcategory,rawfields_skillsubcategory,rawfields_reportto,rawfields_officephone,rawfields_officeext,rawfields_officefax,rawfields_officeemail,rawfields_directdial,rawfields_mobilephone,rawfields_officeaddress1,rawfields_officeaddress2,rawfields_officecity,rawfields_officestate,rawfields_officezip,rawfields_officecountry,rawfields_school,rawfields_degree,rawfields_graduationyear,rawfields_country,rawfields_salary,rawfields_bonus,rawfields_compensation,rawfields_citizenship,rawfields_diversitycandidate,rawfields_entrydate,rawfields_lastupdate,clean_contact_name_title,clean_contact_name_fname,clean_contact_name_mname,clean_contact_name_lname,clean_contact_name_name_suffix,clean_contact_name_name_score,clean_contact_address_prim_range,clean_contact_address_predir,clean_contact_address_prim_name,clean_contact_address_addr_suffix,clean_contact_address_postdir,clean_contact_address_unit_desig,clean_contact_address_sec_range,clean_contact_address_p_city_name,clean_contact_address_v_city_name,clean_contact_address_st,clean_contact_address_zip,clean_contact_address_zip4,clean_contact_address_cart,clean_contact_address_cr_sort_sz,clean_contact_address_lot,clean_contact_address_lot_order,clean_contact_address_dbpc,clean_contact_address_chk_digit,clean_contact_address_rec_type,clean_contact_address_fips_state,clean_contact_address_fips_county,clean_contact_address_geo_lat,clean_contact_address_geo_long,clean_contact_address_msa,clean_contact_address_geo_blk,clean_contact_address_geo_match,clean_contact_address_err_stat,clean_dates_entrydate,clean_dates_lastupdate,clean_phones_officephone,clean_phones_directdial,clean_phones_mobilephone,global_sid,record_sid';
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
    + 'MODULE:Scrubs_Sheila_Greco\n'
    + 'FILENAME:Sheila_Greco\n'
    + 'NAMESCOPE:Contacts\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/\\(\\))\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Fn_Valid_Date > 0 )\n'
    + 'FIELDTYPE:Invalid_AlphaCaps:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'`.,)\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@&/`\'\\(\\))\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz _.,-@#&/`\'\\(\\))\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_AlphaCaps):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)\n'
    + '\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:ace_aid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:rawfields_maincontactid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_maincompanyid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_active:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_firstname:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_midinital:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_lastname:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_age:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_gender:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:rawfields_primarytitle:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_titlelevel1:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_primarydept:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_secondtitle:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_titlelevel2:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_seconddept:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_thirdtitle:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_titlelevel3:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_thirddept:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_skillcategory:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_skillsubcategory:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_reportto:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_officephone:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_officeext:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_officefax:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_officeemail:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:rawfields_directdial:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_mobilephone:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_officeaddress1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:rawfields_officeaddress2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:rawfields_officecity:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_officestate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:rawfields_officezip:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:rawfields_officecountry:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:rawfields_school:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_degree:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_graduationyear:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_country:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:rawfields_salary:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_bonus:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_compensation:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_citizenship:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:rawfields_diversitycandidate:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_entrydate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:rawfields_lastupdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:clean_contact_name_title:TYPE(STRING5):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_name_fname:TYPE(STRING20):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_name_mname:TYPE(STRING20):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_name_lname:TYPE(STRING20):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_name_name_suffix:TYPE(STRING5):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_name_name_score:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_prim_range:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_predir:TYPE(STRING2):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_prim_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_contact_address_addr_suffix:TYPE(STRING4):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_postdir:TYPE(STRING2):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_unit_desig:TYPE(STRING10):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_sec_range:TYPE(STRING8):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_p_city_name:TYPE(STRING25):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_v_city_name:TYPE(STRING25):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_st:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:clean_contact_address_zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:clean_contact_address_zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_contact_address_cr_sort_sz:TYPE(STRING1):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_lot:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_lot_order:TYPE(STRING1):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_dbpc:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_rec_type:TYPE(STRING2):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:clean_contact_address_fips_state:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_fips_county:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_contact_address_geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_contact_address_msa:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_geo_blk:TYPE(STRING7):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_geo_match:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_contact_address_err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_dates_entrydate:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:clean_dates_lastupdate:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:clean_phones_officephone:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_phones_directdial:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_phones_mobilephone:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

