// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT Base_GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.1';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Credit_Unions';
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
  EXPORT spc_FILENAME := 'Credit_Unions';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,source_rec_id,bdid,record_type,raw_aid,ace_aid,dt_vendor_first_reported,dt_vendor_last_reported,charter,cycle_date,join_number,siteid,cu_name,sitename,sitetypename,mainoffice,addrtype,address1,address2,city,state,statename,zip_code,countyname,country,phone,contact_name,assets,loans,networthratio,perc_sharegrowth,perc_loangrowth,loantoassetsratio,investassetsratio,nummem,numfull,title,fname,mname,lname,name_suffix,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_state,fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,prep_addr_line1,prep_addr_line_last';
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
    + 'MODULE:Scrubs_Credit_Unions\n'
    + 'FILENAME:Credit_Unions\n'
    + 'NAMESCOPE:Base\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Credit_Unions.Functions.fn_verify_phone>0)\n'
    + 'FIELDTYPE:invalid_cycle_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_valid_past_Date > 0)\n'
    + 'FIELDTYPE:invalid_join_number:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_siteid:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_address_type_code:ENUM(PHYSICAL|MAILING|)\n'
    + 'FIELDTYPE:invalid_zip_code:ALLOW( 0123456789-)\n'
    + 'FIELDTYPE:invalid_country:CUSTOM(Scrubs_Credit_Unions.Functions.fn_verify_country > 0)\n'
    + 'FIELDTYPE:invalid_bdid:CUSTOM(Scrubs_Credit_Unions.Functions.fn_bdid > 0)\n'
    + 'FIELDTYPE:invalid_sitetypename:ENUM(BRANCH OFFICE|CORPORATE OFFICE|)\n'
    + 'FIELDTYPE:invalid_mainoffice:ENUM(YES|NO|)\n'
    + 'FIELDTYPE:invalid_st_code:CUSTOM(Scrubs_Credit_Unions.Functions.fn_verify_st_code>0)\n'
    + 'FIELDTYPE:invalid_st_name:CUSTOM(Scrubs_Credit_Unions.Functions.fn_verify_state_name>0)\n'
    + 'FIELDTYPE:invalid_source_rec_id:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_charter:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_financial_num:ALLOW( 0123456789-.Ee)\n'
    + 'FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs_Credit_Unions.Functions.fn_numeric_or_blank > 0)\n'
    + '// FIELDTYPE:invalid_current_future_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_current_future_date > 0)\n'
    + '// FIELDTYPE:invalid_current_past_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_current_past_date > 0)\n'
    + '// FIELDTYPE:invalid_future_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_future_date > 0)\n'
    + '// FIELDTYPE:invalid_general_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_valid_generalDate > 0)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs_Credit_Unions.Functions.fn_valid_past_Date > 0)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_source_rec_id):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_bdid):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:ace_aid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0\n'
    + '// FIELD:date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + '// FIELD:date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:charter:TYPE(STRING):LIKE(invalid_charter):0,0\n'
    + 'FIELD:cycle_date:TYPE(STRING):LIKE(invalid_cycle_date):0,0\n'
    + 'FIELD:join_number:TYPE(STRING):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:siteid:TYPE(STRING):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:cu_name:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:sitename:TYPE(STRING):0,0\n'
    + 'FIELD:sitetypename:TYPE(STRING):LIKE(invalid_sitetypename):0,0\n'
    + 'FIELD:mainoffice:TYPE(STRING):LIKE(invalid_mainoffice):0,0\n'
    + 'FIELD:addrtype:TYPE(STRING):LIKE(invalid_address_type_code):0,0\n'
    + 'FIELD:address1:TYPE(STRING):0,0\n'
    + 'FIELD:address2:TYPE(STRING):0,0\n'
    + 'FIELD:city:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(invalid_st_code):0,0\n'
    + 'FIELD:statename:TYPE(STRING):LIKE(invalid_st_name):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING):LIKE(invalid_zip_code):0,0\n'
    + 'FIELD:countyname:TYPE(STRING):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(invalid_country):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:contact_name:TYPE(STRING):0,0\n'
    + 'FIELD:assets:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:loans:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:networthratio:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:perc_sharegrowth:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:perc_loangrowth:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:loantoassetsratio:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:investassetsratio:TYPE(STRING):LIKE(invalid_financial_num):0,0\n'
    + 'FIELD:nummem:TYPE(STRING):0,0\n'
    + 'FIELD:numfull:TYPE(STRING):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
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
    + 'FIELD:dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '\n'
    + '\n'
    + '//-----------------------------\n'
    + '//FIELDS NOT BEING SCRUBBED\n'
    + '//-----------------------------\n'
    + '// FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:bdid_score:TYPE(UNSIGNED1):0,0\n'
    + '// FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:TYPE(UNSIGNED2):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

