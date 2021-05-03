// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT InfutorWP_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'CanadianPhones';
  EXPORT spc_NAMESCOPE := 'InfutorWP';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'record_id'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'CanadianPhones';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:record_id';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,date_first_reported,date_last_reported,vendor,source_file,lastname,firstname,middlename,name,nickname,generational,title,professionalsuffix,housenumber,directional,streetname,streetsuffix,suitenumber,suburbancity,postalcity,province,postalcode,provincecode,county_code,phonenumber,phonetypeflag,nosolicitation,cmacode,prim_range,predir,prim_name,addr_suffix,unit_desig,sec_range,p_city_name,state,zip,rec_type,language,errstat,company_name,record_use_indicator,city,pub_date,latitude,longitude,lat_long_level_applied,book_number,secondary_name,room_number,room_code,record_type,yphc_1,yphc_2,yphc_3,yphc_4,yphc_5,yphc_6,sic_1,sic_2,sic_3,sic_4,bus_govt_indicator,status_indicator,selected_sic,franchise_codes,ad_size,french_flag,population_code,individual_firm_code,year_of_1st_appearance_ccyy,date_added_to_db_ccyymm,title_code,contact_gender_code,employee_size_code,sales_volume_code,industry_specific_code,business_status_code,key_code,fax_phone,office_size_code,production_date_mmddccyy,abi_number,subsidiary_parent_number,ultimate_parent_number,primary_sic,secondary_sic_code_1,secondary_sic_code_2,secondary_sic_code_3,secondary_sic_code_4,total_employee_size_code,total_output_sales_code,number_of_employees_actual,total_no_employees_actual,postal_mode,postal_bag_bundle,transaction_code,listing_type,name_title,fname,mname,lname,name_suffix,name_score,global_sid,record_sid';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    'OPTIONS:-gn\n'
    + 'MODULE:CanadianPhones\n'
    + 'FILENAME:CanadianPhones\n'
    + 'NAMESCOPE:InfutorWP\n'
    + '\n'
    + 'RIDFIELD:record_id:GENERATE\n'
    + 'INGESTFILE:InfutorWP_update:NAMED(CanadianPhones.InfutorWP_ingest_prep)\n'
    + '\n'
    + 'FIELD:date_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:vendor:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:source_file:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:lastname:TYPE(STRING20):0,0\n'
    + 'FIELD:firstname:TYPE(STRING15):0,0\n'
    + 'FIELD:middlename:TYPE(STRING15):0,0\n'
    + 'FIELD:name:TYPE(STRING50):0,0\n'
    + 'FIELD:nickname:TYPE(STRING15):0,0\n'
    + 'FIELD:generational:TYPE(STRING3):0,0\n'
    + 'FIELD:title:TYPE(STRING4):0,0\n'
    + 'FIELD:professionalsuffix:TYPE(STRING4):0,0\n'
    + 'FIELD:housenumber:TYPE(STRING10):0,0\n'
    + 'FIELD:directional:TYPE(STRING3):0,0\n'
    + 'FIELD:streetname:TYPE(STRING35):0,0\n'
    + 'FIELD:streetsuffix:TYPE(STRING7):0,0\n'
    + 'FIELD:suitenumber:TYPE(STRING9):0,0\n'
    + 'FIELD:suburbancity:TYPE(STRING30):0,0\n'
    + 'FIELD:postalcity:TYPE(STRING30):0,0\n'
    + 'FIELD:province:TYPE(STRING2):0,0\n'
    + 'FIELD:postalcode:TYPE(STRING6):0,0\n'
    + 'FIELD:provincecode:TYPE(STRING2):0,0\n'
    + 'FIELD:county_code:TYPE(STRING3):0,0\n'
    + 'FIELD:phonenumber:TYPE(STRING10):0,0\n'
    + 'FIELD:phonetypeflag:TYPE(STRING4):0,0\n'
    + 'FIELD:nosolicitation:TYPE(STRING4):0,0\n'
    + 'FIELD:cmacode:TYPE(STRING4):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:state:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING6):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:language:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:errstat:DERIVED:TYPE(STRING6):0,0\n'
    + 'FIELD:company_name:TYPE(STRING60):0,0\n'
    + '//FIELD:record_id:TYPE(STRING10):0,0\n'
    + 'FIELD:record_use_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:city:TYPE(STRING25):0,0\n'
    + 'FIELD:pub_date:TYPE(STRING6):0,0\n'
    + 'FIELD:latitude:TYPE(STRING10):0,0\n'
    + 'FIELD:longitude:TYPE(STRING10):0,0\n'
    + 'FIELD:lat_long_level_applied:TYPE(STRING1):0,0\n'
    + 'FIELD:book_number:TYPE(STRING6):0,0\n'
    + 'FIELD:secondary_name:TYPE(STRING30):0,0\n'
    + 'FIELD:room_number:TYPE(STRING4):0,0\n'
    + 'FIELD:room_code:TYPE(STRING3):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):0,0\n'
    + 'FIELD:yphc_1:TYPE(STRING6):0,0\n'
    + 'FIELD:yphc_2:TYPE(STRING6):0,0\n'
    + 'FIELD:yphc_3:TYPE(STRING6):0,0\n'
    + 'FIELD:yphc_4:TYPE(STRING6):0,0\n'
    + 'FIELD:yphc_5:TYPE(STRING6):0,0\n'
    + 'FIELD:yphc_6:TYPE(STRING6):0,0\n'
    + 'FIELD:sic_1:TYPE(STRING8):0,0\n'
    + 'FIELD:sic_2:TYPE(STRING8):0,0\n'
    + 'FIELD:sic_3:TYPE(STRING8):0,0\n'
    + 'FIELD:sic_4:TYPE(STRING8):0,0\n'
    + 'FIELD:bus_govt_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:status_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:selected_sic:TYPE(STRING6):0,0\n'
    + 'FIELD:franchise_codes:TYPE(STRING6):0,0\n'
    + 'FIELD:ad_size:TYPE(STRING1):0,0\n'
    + 'FIELD:french_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:population_code:TYPE(STRING1):0,0\n'
    + 'FIELD:individual_firm_code:TYPE(STRING1):0,0\n'
    + 'FIELD:year_of_1st_appearance_ccyy:TYPE(STRING4):0,0\n'
    + 'FIELD:date_added_to_db_ccyymm:TYPE(STRING6):0,0\n'
    + 'FIELD:title_code:TYPE(STRING1):0,0\n'
    + 'FIELD:contact_gender_code:TYPE(STRING1):0,0\n'
    + 'FIELD:employee_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:sales_volume_code:TYPE(STRING1):0,0\n'
    + 'FIELD:industry_specific_code:TYPE(STRING1):0,0\n'
    + 'FIELD:business_status_code:TYPE(STRING1):0,0\n'
    + 'FIELD:key_code:TYPE(STRING10):0,0\n'
    + 'FIELD:fax_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:office_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:production_date_mmddccyy:TYPE(STRING8):0,0\n'
    + 'FIELD:abi_number:TYPE(STRING9):0,0\n'
    + 'FIELD:subsidiary_parent_number:TYPE(STRING9):0,0\n'
    + 'FIELD:ultimate_parent_number:TYPE(STRING9):0,0\n'
    + 'FIELD:primary_sic:TYPE(STRING6):0,0\n'
    + 'FIELD:secondary_sic_code_1:TYPE(STRING6):0,0\n'
    + 'FIELD:secondary_sic_code_2:TYPE(STRING6):0,0\n'
    + 'FIELD:secondary_sic_code_3:TYPE(STRING6):0,0\n'
    + 'FIELD:secondary_sic_code_4:TYPE(STRING6):0,0\n'
    + 'FIELD:total_employee_size_code:TYPE(STRING1):0,0\n'
    + 'FIELD:total_output_sales_code:TYPE(STRING1):0,0\n'
    + 'FIELD:number_of_employees_actual:TYPE(STRING6):0,0\n'
    + 'FIELD:total_no_employees_actual:TYPE(STRING6):0,0\n'
    + 'FIELD:postal_mode:TYPE(STRING9):0,0\n'
    + 'FIELD:postal_bag_bundle:TYPE(STRING9):0,0\n'
    + 'FIELD:transaction_code:TYPE(STRING1):0,0\n'
    + 'FIELD:listing_type:TYPE(STRING1):0,0\n'
    + 'FIELD:name_title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:global_sid:DERIVED:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

