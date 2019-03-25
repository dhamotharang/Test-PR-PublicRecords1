import data_services ; 
export File_OK_Payne := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::ok_payne', layout_ok_adair, csv(separator('|'), quote(''), maxlength(6000)));