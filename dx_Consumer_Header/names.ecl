IMPORT data_services, doxie, STD;

// common for all indices name prefix
string prefix := '~' + 'thor_data400::key::';

// a default version is chosen so that the user of an index won't have to provide any specific value;
// when building keys using existing procedures, an empty string will have to be specified. 
EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

  EXPORT i_did      := prefix + 'insuranceheader_best::' + file_version + '::did'; 

END;