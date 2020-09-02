IMPORT data_services, doxie;

EXPORT names(STRING file_version = doxie.Version_SuperKey):= MODULE
  SHARED STRING prefix        :=  Data_Services.Data_Location.Prefix('Utility') + 'thor_data400::key::';
  SHARED STRING postfix       := IF (file_version != '', '_' + file_version, '');

//full keys
  EXPORT i_address            := prefix + 'utility_address'             + postfix;
  EXPORT i_did                := prefix + 'utility_did'                 + postfix;
  EXPORT i_linkids            := prefix + 'utility::'                   + IF(file_version !='', file_version, '@version@') + '::linkids';
//daily keys	
  EXPORT i_did_daily          := prefix + 'utility::daily.did'          + postfix;
  EXPORT i_fdid_daily         := prefix + 'utility::daily.fdid'         + postfix;
//daily auto keys
  EXPORT i_auto_ssn           := prefix + 'utility::daily.ssn'          + postfix;

END;

