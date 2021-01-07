// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Deltabase_GenerationMod := MODULE(SALT311.iGenerationMod)
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FraudGov';
  EXPORT spc_NAMESCOPE := 'Deltabase';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Deltabase';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,inqlog_id,customer_id,transaction_id,date_of_transaction,household_id,customer_person_id,customer_program,reason_for_transaction_activity,inquiry_source,customer_county,customer_state,customer_agency_vertical_type,ssn,dob,rawlinkid,raw_full_name,raw_title,raw_first_name,raw_middle_name,raw_last_name,raw_orig_suffix,full_address,street_1,city,state,zip,county,mailing_street_1,mailing_city,mailing_state,mailing_zip,mailing_county,phone_number,ultid,orgid,seleid,tin,email_address,appended_provider_id,lnpid,npi,ip_address,device_id,professional_id,bank_routing_number_1,bank_account_number_1,drivers_license_state,drivers_license,geo_lat,geo_long,reported_date,file_type,deceitful_confidence,reported_by,reason_description,event_type_1,event_entity_1';
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
    'ï»¿OPTIONS:-gh\n'
    + 'MODULE:Scrubs_FraudGov\n'
    + 'FILENAME:Deltabase\n'
    + 'NAMESCOPE:Deltabase\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):ONFAIL(BLANK) \n'
    + 'FIELDTYPE:invalid_date:ALLOW(\\N0123456789):SPACES( ./:-):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric_string:ALLOW(\\N-0123456789):ONFAIL(BLANK) \n'
    + 'FIELDTYPE:invalid_real:ALLOW(-.,0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_real_string:ALLOW(\\N-.,0123456789):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(\\N-0123456789):SPACES( -):LEFTTRIM:LENGTHS(0,2,5,9,10):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,2):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ssn:ALLOW(\\N0123456789):SPACES( -):LEFTTRIM:LENGTHS(0,2,9..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(\\N0123456789):SPACES( +#()-):LEFTTRIM:LENGTHS(0,2,10..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ip:ALLOW(\\N.x0123456789):SPACES( .):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:SPACES( \',):ONFAIL(BLANK)\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:inqlog_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:customer_id:TYPE(STRING20):LIKE(invalid_numeric_string):0,0\n'
    + 'FIELD:transaction_id:TYPE(STRING):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:date_of_transaction:TYPE(STRING10):LIKE(invalid_date):0,0\n'
    + 'FIELD:household_id:TYPE(STRING20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:customer_person_id:TYPE(STRING20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:customer_program:TYPE(STRING1):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:reason_for_transaction_activity:TYPE(STRING):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:inquiry_source:TYPE(STRING100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:customer_county:TYPE(STRING3):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:customer_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:customer_agency_vertical_type:TYPE(STRING):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:ssn:TYPE(STRING10):LIKE(invalid_ssn):0,0\n'
    + 'FIELD:dob:TYPE(STRING10):LIKE(invalid_date):0,0\n'
    + 'FIELD:rawlinkid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:raw_full_name:TYPE(STRING100):LIKE(invalid_name):0,0\n'
    + 'FIELD:raw_title:TYPE(STRING50):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:raw_first_name:TYPE(STRING100):LIKE(invalid_name):0,0\n'
    + 'FIELD:raw_middle_name:TYPE(STRING60):LIKE(invalid_name):0,0\n'
    + 'FIELD:raw_last_name:TYPE(STRING100):LIKE(invalid_name):0,0\n'
    + 'FIELD:raw_orig_suffix:TYPE(STRING10):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:full_address:TYPE(STRING):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:street_1:TYPE(STRING100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:city:TYPE(STRING100):LIKE(invalid_name):0,0\n'
    + 'FIELD:state:TYPE(STRING10):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip:TYPE(STRING10):LIKE(invalid_zip):0,0\n'
    + 'FIELD:county:TYPE(STRING3):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:mailing_street_1:TYPE(STRING100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:mailing_city:TYPE(STRING30):LIKE(invalid_name):0,0\n'
    + 'FIELD:mailing_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mailing_zip:TYPE(STRING9):LIKE(invalid_zip):0,0\n'
    + 'FIELD:mailing_county:TYPE(STRING3):LIKE(invalid_alphanumeric):0,0 \n'
    + 'FIELD:phone_number:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:tin:TYPE(STRING10):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:email_address:TYPE(STRING256):LIKE(invalid_email):0,0\n'
    + 'FIELD:appended_provider_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:lnpid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:npi:TYPE(STRING10):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:ip_address:TYPE(STRING25):LIKE(invalid_ip):0,0\n'
    + 'FIELD:device_id:TYPE(STRING50):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:professional_id:TYPE(STRING12):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:bank_routing_number_1:TYPE(STRING20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:bank_account_number_1:TYPE(STRING20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:drivers_license_state:TYPE(STRING2):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:drivers_license:TYPE(STRING25):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_real_string):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(invalid_real_string):0,0\n'
    + 'FIELD:reported_date:TYPE(STRING75):LIKE(invalid_date):0,0\n'
    + 'FIELD:file_type:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:deceitful_confidence:TYPE(STRING10):LIKE(invalid_numeric_string):0,0\n'
    + 'FIELD:reported_by:TYPE(STRING30):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:reason_description:TYPE(STRING250):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:event_type_1:TYPE(STRING30):LIKE(invalid_numeric_string):0,0\n'
    + 'FIELD:event_entity_1:TYPE(STRING30):LIKE(invalid_alphanumeric):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
END;

