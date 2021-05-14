// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SalesChannel';
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
  EXPORT spc_FILENAME := 'SalesChannel';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,rid,bdid,bdid_score,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,did,did_score,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,rawaid,aceaid,record_type,rawfields_row_id,rawfields_company_name,rawfields_web_address,rawfields_prefix,rawfields_contact_name,rawfields_first_name,rawfields_middle_name,rawfields_last_name,rawfields_title,rawfields_address,rawfields_address1,rawfields_city,rawfields_state,rawfields_zip_code,rawfields_country,rawfields_phone_number,rawfields_email,clean_name_title,clean_name_fname,clean_name_mname,clean_name_lname,clean_name_name_suffix,clean_name_name_score,clean_address_prim_range,clean_address_predir,clean_address_prim_name,clean_address_addr_suffix,clean_address_postdir,clean_address_unit_desig,clean_address_sec_range,clean_address_p_city_name,clean_address_v_city_name,clean_address_st,clean_address_zip,clean_address_zip4,clean_address_cart,clean_address_cr_sort_sz,clean_address_lot,clean_address_lot_order,clean_address_dbpc,clean_address_chk_digit,clean_address_rec_type,clean_address_fips_state,clean_address_fips_county,clean_address_geo_lat,clean_address_geo_long,clean_address_msa,clean_address_geo_blk,clean_address_geo_match,clean_address_err_stat,global_sid,record_sid,current_rec';
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
    + 'MODULE:Scrubs_SalesChannel\n'
    + 'FILENAME:SalesChannel\n'
    + '\n'
    + 'FIELDTYPE:Invalid_PrintableChar:CUSTOM(Scrubs_SalesChannel.Functions.fn_ASCII_printable>0)\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-,/)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ .-\')\n'
    + 'FIELDTYPE:Invalid_AlphaChars:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@\\(\\))\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-/:;&#\'@\\(\\))\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)\n'
    + '\n'
    + 'FIELD:rid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(Invalid_No):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_first_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_last_seen:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):LIKE(Invalid_No):0,0\n'
    + 'FIELD:aceaid:TYPE(UNSIGNED8):LIKE(Invalid_No):0,0\n'
    + 'FIELD:record_type:TYPE(UNSIGNED1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_row_id:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:rawfields_company_name:TYPE(STRING50):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_web_address:TYPE(STRING80):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_prefix:TYPE(STRING8_):LIKE(Invalid_AlphaChars):0,0\n'
    + 'FIELD:rawfields_contact_name:TYPE(STRING60):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_first_name:TYPE(STRING30):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_middle_name:TYPE(STRING20):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_last_name:TYPE(STRING30):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_title:TYPE(STRING170):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_address:TYPE(STRING40):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_address1:TYPE(STRING20):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:rawfields_city:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:rawfields_zip_code:TYPE(STRING10):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:rawfields_country:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:rawfields_phone_number:TYPE(STRING15):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:rawfields_email:TYPE(STRING50):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:clean_name_title:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_name_fname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_name_mname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_name_lname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_name_name_suffix:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_name_name_score:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_prim_range:TYPE(STRING10):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:clean_address_predir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_prim_name:TYPE(STRING28):LIKE(Invalid_PrintableChar):0,0\n'
    + 'FIELD:clean_address_addr_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_postdir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_unit_desig:TYPE(STRING10):LIKE(Invalid_AlphaChars):0,0\n'
    + 'FIELD:clean_address_sec_range:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_address_p_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_v_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_st:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:clean_address_zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:clean_address_zip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:clean_address_cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_lot:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_dbpc:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_rec_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clean_address_fips_state:TYPE(STRING2):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_fips_county:TYPE(STRING3):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_address_geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:clean_address_msa:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_geo_blk:TYPE(STRING7):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_geo_match:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:clean_address_err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):LIKE(Invalid_No):0,0\n'
    + 'FIELD:current_rec:TYPE(BOOLEAN):LIKE(Invalid_No):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

