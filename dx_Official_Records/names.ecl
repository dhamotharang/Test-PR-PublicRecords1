IMPORT data_services, doxie;

EXPORT names(STRING file_version = doxie.Version_SuperKey):= MODULE

  SHARED STRING prefix := Data_Services.Data_Location.Prefix('official_records') + 'thor_200::key::official_records';
  SHARED STRING postfix := IF (file_version != '', '_' + file_version, '');
  EXPORT ak_prefix := prefix + '::autokey::';

  EXPORT i_document := prefix + '_document_orid' + postfix;
  EXPORT i_party := prefix + '_party_orid' + postfix;
  EXPORT i_ak_payload := ak_prefix + 'payload';

END;
