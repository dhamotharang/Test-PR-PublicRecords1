// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT InquiryLogs_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FraudGov';
  EXPORT spc_NAMESCOPE := 'InquiryLogs';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'InquiryLogs';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,transaction_id,datetime,full_name,title,fname,mname,lname,name_suffix,ssn,appended_ssn,address,city,state,zip,fips_county,personal_phone,dob,email_address,dl_st,dl,ipaddr,geo_lat,geo_long,Source';
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
    + 'MODULE:Scrubs_FraudGov\n'
    + 'FILENAME:InquiryLogs\n'
    + 'NAMESCOPE:InquiryLogs \n'
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
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(0,4..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,8..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(-0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,5..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,2):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ssn:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,9):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,10..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ip:ALLOW(.0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:SPACES( <>{}[]-^=\'`!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_decimal:ALLOW(-.,0123456789)\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0. If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + 'FIELD:transaction_id:TYPE(string):LIKE(invalid_alphanumeric):0,0 \n'
    + 'FIELD:datetime:TYPE(string):LIKE(invalid_date):0,0 \n'
    + 'FIELD:full_name:TYPE(string):LIKE(invalid_name):0,0 \n'
    + 'FIELD:title:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:fname:TYPE(string):LIKE(invalid_name):0,0\n'
    + 'FIELD:mname:TYPE(string):LIKE(invalid_name):0,0\n'
    + 'FIELD:lname:TYPE(string):LIKE(invalid_name):0,0\n'
    + 'FIELD:name_suffix:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:ssn:TYPE(string):LIKE(invalid_ssn):0,0\n'
    + 'FIELD:appended_ssn:TYPE(string):LIKE(invalid_ssn):0,0\n'
    + 'FIELD:address:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:city:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:state:TYPE(string):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip:TYPE(string):LIKE(invalid_zip):0,0\n'
    + 'FIELD:fips_county:TYPE(string3):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:personal_phone:TYPE(string):LIKE(invalid_phone):0,0\n'
    + 'FIELD:dob:TYPE(string):LIKE(invalid_date):0,0\n'
    + 'FIELD:email_address:TYPE(string):LIKE(invalid_email):0,0\n'
    + 'FIELD:dl_st:TYPE(string):LIKE(invalid_state):0,0\n'
    + 'FIELD:dl:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:ipaddr:TYPE(string):LIKE(invalid_ip):0,0\n'
    + 'FIELD:geo_lat:TYPE(string10):LIKE(invalid_decimal):0,0\n'
    + 'FIELD:geo_long:TYPE(string11):LIKE(invalid_decimal):0,0\n'
    + 'FIELD:Source:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

