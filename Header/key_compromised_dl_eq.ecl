IMPORT data_services;

in_file:= dataset([],header.layout_key_compromised_dl_eq);

EXPORT key_compromised_dl_eq := index(
            
            in_file
            ,{in_file}
            ,{in_file}
            ,data_services.Data_location.prefix('person_header')
            +'thor_data400::key::header::refs::qa::compromised_dl_eq');