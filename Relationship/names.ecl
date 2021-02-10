import doxie,_control, Data_Services;

location := IF (_control.ThisEnvironment.Name = 'Alpha_Dev', Data_Services.Data_Location.Prefix('RELATIVES'), '~');

string prefix := '~' + 'thor_data400::key::';

EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

   SHARED string postfix := IF (file_version != '', '_' + file_version, '');  
   
   EXPORT skeyNthDegree := prefix + 'Relatives_Nth' + postfix;

END;