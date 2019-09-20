import data_services; 
export File_ok_Garfield := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::ok::garfield', layout_ok_adair, csv(separator('|'), quote(''), maxlength(6000)));