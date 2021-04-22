IMPORT data_services, doxie;

EXPORT names(STRING file_version = doxie.Version_SuperKey):= MODULE
  SHARED STRING prefix        :=  Data_Services.Data_Location.Prefix('official_records') + 'thor_200::key::official_records_';
  SHARED STRING postfix       := IF (file_version != '', '_' + file_version, '');

  EXPORT i_document      := prefix + 'document_orid'                + postfix;
  EXPORT i_party         := prefix + 'party_orid'                   + postfix;

END;

