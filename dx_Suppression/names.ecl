IMPORT Data_Services, doxie, STD;

STRING prefix := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::';


EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

  SHARED string postfix := IF (file_version != '', '::' + file_version, '::');

  EXPORT i_suppression := prefix + 'suppression' + postfix + '::link_type_link_id';
  EXPORT i_suppression_fcra := prefix + 'suppression::fcra' + postfix + '::link_type_link_id';
END;
