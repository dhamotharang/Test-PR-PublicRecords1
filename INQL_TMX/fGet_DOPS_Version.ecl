Import STD, Data_Services, dops;

EXPORT fGetCurrentVersion := Module;

SHARED version_regexp    := '([0-9]{8}[a-z]?)';

// KJE - Comment out as there is nothing in production or Cert currently...
// EXPORT tmx_keys_dops_prod    := dops.Getbuildversion('ThreatMetrixKeys','B','N','P');
// EXPORT tmx_keys_dops_certQA  := dops.Getbuildversion('ThreatMetrixKeys','B','N','C');

// KJE - Temporary
EXPORT tmx_test_file         := sort(nothor(fileservices.superfilecontents(INQL_TMX.Filenames().Base.QA)), -name)[1].name;
EXPORT tmx_version_test      := regexfind(version_regexp, tmx_test_file, 1);	
// EXPORT tmx_version_test      := '20190125';

EXPORT tmx_keys_dops_prod    := tmx_version_test;
EXPORT tmx_keys_dops_certQA  := tmx_version_test;




EXPORT tmx_base_file         := sort(nothor(fileservices.superfilecontents(INQL_TMX.Filenames().Base.QA)), -name)[1].name;
EXPORT tmx_base_version      := regexfind(version_regexp, tmx_base_file, 1);	

EXPORT tmx_key_file          := sort(nothor(fileservices.superfilecontents(INQL_TMX.Keynames().Search_ID.QA)), -name)[1].name;
EXPORT tmx_key_version       := regexfind(version_regexp, tmx_key_file, 1);	

// KJE TBD - As we are using a simple sample file to run our Unit Testing against. We need to change this file name
// to the final version whence the ThreatMetrix data feed files and process are finalised and in place.
// EXPORT tmx_input_file        := nothor(fileservices.superfilecontents(INQL_TMX.Filenames().Input.QA))[1].name;
// EXPORT tmx_input_version     := regexfind(version_regexp, tmx_input_file, 1);	

// KJE - Temporary below...
EXPORT tmx_input_file        := INQL_TMX.Filenames().Input.root;
EXPORT tmx_input_version     := regexfind(version_regexp, tmx_key_file, 1);	

end;