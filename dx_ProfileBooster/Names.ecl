IMPORT data_services, doxie;

STRING prefix := data_services.data_location.ProfileBooster + 'thor_data400::key::';

EXPORT names (STRING file_version = doxie.Version_SuperKey):= MODULE

   SHARED STRING postfix := IF (file_version != '', '_' + file_version, '');  
   
   EXPORT i_lexid := prefix + 'ProfileBooster::lexid_sample' + postfix;
   // EXPORT i_lexid := prefix + 'ProfileBooster::lexid' + postfix;
   EXPORT i_address := prefix + 'ProfileBooster::address' + postfix;

END;