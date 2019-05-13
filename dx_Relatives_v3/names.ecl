import data_services, doxie;

string prefix := data_services.data_location.person_header + 'thor_data400::key::';

EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

   SHARED string postfix := IF (file_version != '', '_' + file_version, '');  
   
   EXPORT i_D2C_Header_Relatives := prefix + 'header::D2C_Header_Relatives' + postfix;
   EXPORT i_Marketing_Header_Relatives := prefix + 'header::Marketing_Header_Relatives' + postfix;

END;