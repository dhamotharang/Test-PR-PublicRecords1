// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DataBridge';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'DataBridge';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,process_date,record_type,clean_company_name,clean_telephone_num,state,zip_code5,mail_score,name_gender,web_address,sic8_1,sic8_2,sic8_3,sic8_4,sic6_1,sic6_2,sic6_3,sic6_4,sic6_5,transaction_date,database_site_id,database_individual_id,email,email_present_flag,site_source1,site_source2,site_source3,site_source4,site_source5,site_source6,site_source7,site_source8,site_source9,site_source10,individual_source1,individual_source2,individual_source3,individual_source4,individual_source5,individual_source6,individual_source7,individual_source8,individual_source9,individual_source10,email_status';
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
    + 'MODULE:Scrubs_DataBridge\n'
    + 'FILENAME:DataBridge\n'
    + 'NAMESCOPE:Base\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_generaldate:CUSTOM(Scrubs_DataBridge.Functions.fn_general_date > 0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_DataBridge.Functions.fn_past_yyyymmdd > 0)\n'
    + 'FIELDTYPE:invalid_trans_date:CUSTOM(Scrubs_DataBridge.Functions.fn_trans_date > 0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_DataBridge.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_DataBridge.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_DataBridge.Functions.fn_numeric > 0,5)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_DataBridge.Functions.fn_verify_optional_phone > 0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs_DataBridge.Functions.fn_sic > 0)\n'
    + 'FIELDTYPE:invalid_url:CUSTOM(Scrubs_DataBridge.Functions.fn_url > 0)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&)\n'
    + 'FIELDTYPE:invalid_mail_score:ENUM(1|2|3|4|5|6|7|8)\n'
    + 'FIELDTYPE:invalid_gender_code:ENUM(0|1|2|3|4|UNDEFINED|)\n'
    + 'FIELDTYPE:invalid_email_present_flag:ENUM(0|1|2|3)\n'
    + 'FIELDTYPE:invalid_source_code:ENUM(0|1)\n'
    + 'FIELDTYPE:invalid_email_status:ENUM(VALID|INVALID|UNKNOWN|)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '\n'
    + '// FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:did_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date:TYPE(UNSIGNED4):LIKE(invalid_generaldate):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:clean_company_name:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + '//FIELD:clean_area_code:TYPE(STRING3):0,0\n'
    + 'FIELD:clean_telephone_num:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + '// FIELD:mail_score_desc:TYPE(STRING13):0,0\n'
    + '// FIELD:name_gender_desc:TYPE(STRING9):0,0\n'
    + '// FIELD:title_desc_1:TYPE(STRING40):0,0\n'
    + '// FIELD:title_desc_2:TYPE(STRING40):0,0\n'
    + '// FIELD:title_desc_3:TYPE(STRING40):0,0\n'
    + '// FIELD:title_desc_4:TYPE(STRING40):0,0\n'
    + '// FIELD:sic8_desc_1:TYPE(STRING75):0,0\n'
    + '// FIELD:sic8_desc_2:TYPE(STRING75):0,0\n'
    + '// FIELD:sic8_desc_3:TYPE(STRING75):0,0\n'
    + '// FIELD:sic8_desc_4:TYPE(STRING75):0,0\n'
    + '// FIELD:sic6_desc_1:TYPE(STRING75):0,0\n'
    + '// FIELD:sic6_desc_2:TYPE(STRING75):0,0\n'
    + '// FIELD:sic6_desc_3:TYPE(STRING75):0,0\n'
    + '// FIELD:sic6_desc_4:TYPE(STRING75):0,0\n'
    + '// FIELD:sic6_desc_5:TYPE(STRING75):0,0\n'
    + '// FIELD:name:TYPE(STRING30):0,0\n'
    + '// FIELD:company:TYPE(STRING50):0,0\n'
    + '// FIELD:address:TYPE(STRING30):0,0\n'
    + '// FIELD:address2:TYPE(STRING30):0,0\n'
    + '// FIELD:city:TYPE(STRING20):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + '// FIELD:scf:TYPE(STRING3):0,0\n'
    + 'FIELD:zip_code5:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + '// FIELD:zip_code4:TYPE(STRING4):0,0\n'
    + 'FIELD:mail_score:TYPE(STRING1):LIKE(invalid_mail_score):0,0\n'
    + '// FIELD:area_code:TYPE(STRING3):0,0\n'
    + '// FIELD:telephone_number:TYPE(STRING10):0,0\n'
    + 'FIELD:name_gender:TYPE(STRING1):LIKE(invalid_gender_code):0,0\n'
    + '// FIELD:name_prefix:TYPE(STRING10):0,0\n'
    + '// FIELD:name_first:TYPE(STRING20):0,0\n'
    + '// FIELD:name_middle_initial:TYPE(STRING1):0,0\n'
    + '// FIELD:name_last:TYPE(STRING20):0,0\n'
    + '// FIELD:suffix:TYPE(STRING10):0,0\n'
    + '// FIELD:title_code_1:TYPE(STRING4):0,0\n'
    + '// FIELD:title_code_2:TYPE(STRING4):0,0\n'
    + '// FIELD:title_code_3:TYPE(STRING4):0,0\n'
    + '// FIELD:title_code_4:TYPE(STRING4):0,0\n'
    + 'FIELD:web_address:TYPE(STRING50):LIKE(invalid_url):0,0\n'
    + 'FIELD:sic8_1:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic8_2:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic8_3:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic8_4:TYPE(STRING8):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic6_1:TYPE(STRING6):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic6_2:TYPE(STRING6):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic6_3:TYPE(STRING6):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic6_4:TYPE(STRING6):LIKE(invalid_sic):0,0\n'
    + 'FIELD:sic6_5:TYPE(STRING6):LIKE(invalid_sic):0,0\n'
    + 'FIELD:transaction_date:TYPE(STRING6):LIKE(invalid_trans_date):0,0\n'
    + 'FIELD:database_site_id:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:database_individual_id:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:email:TYPE(STRING50):LIKE(invalid_email):0,0\n'
    + 'FIELD:email_present_flag:TYPE(STRING1):LIKE(invalid_email_present_flag):0,0\n'
    + 'FIELD:site_source1:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source2:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source3:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source4:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source5:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source6:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source7:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source8:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source9:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:site_source10:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source1:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source2:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source3:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source4:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source5:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source6:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source7:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source8:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source9:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:individual_source10:TYPE(STRING1):LIKE(invalid_source_code):0,0\n'
    + 'FIELD:email_status:TYPE(STRING7):LIKE(invalid_email_status):0,0\n'
    + '// FIELD:title:TYPE(STRING5):0,0\n'
    + '// FIELD:fname:TYPE(STRING20):0,0\n'
    + '// FIELD:mname:TYPE(STRING20):0,0\n'
    + '// FIELD:lname:TYPE(STRING20):0,0\n'
    + '// FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + '// FIELD:name_score:TYPE(STRING3):0,0\n'
    + '// FIELD:prim_range:TYPE(STRING10):0,0\n'
    + '// FIELD:predir:TYPE(STRING2):0,0\n'
    + '// FIELD:prim_name:TYPE(STRING28):0,0\n'
    + '// FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + '// FIELD:postdir:TYPE(STRING2):0,0\n'
    + '// FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + '// FIELD:sec_range:TYPE(STRING8):0,0\n'
    + '// FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + '// FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + '// FIELD:st:TYPE(STRING2):0,0\n'
    + '// FIELD:zip:TYPE(STRING5):0,0\n'
    + '// FIELD:zip4:TYPE(STRING4):0,0\n'
    + '// FIELD:cart:TYPE(STRING4):0,0\n'
    + '// FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + '// FIELD:lot:TYPE(STRING4):0,0\n'
    + '// FIELD:lot_order:TYPE(STRING1):0,0\n'
    + '// FIELD:dbpc:TYPE(STRING2):0,0\n'
    + '// FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + '// FIELD:rec_type:TYPE(STRING2):0,0\n'
    + '// FIELD:fips_state:TYPE(STRING2):0,0\n'
    + '// FIELD:fips_county:TYPE(STRING3):0,0\n'
    + '// FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + '// FIELD:geo_long:TYPE(STRING11):0,0\n'
    + '// FIELD:msa:TYPE(STRING4):0,0\n'
    + '// FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + '// FIELD:geo_match:TYPE(STRING1):0,0\n'
    + '// FIELD:err_stat:TYPE(STRING4):0,0\n'
    + '// FIELD:raw_aid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:ace_aid:TYPE(UNSIGNED8):0,0\n'
    + '// FIELD:prep_address_line1:TYPE(STRING100):0,0\n'
    + '// FIELD:prep_address_line_last:TYPE(STRING50):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

