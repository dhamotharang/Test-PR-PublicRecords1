import data_services ;
export File_OK_rogers := dataset(data_services.foreign_prod+'thor_data400::in::crim_court::ok_rogers', layout_ok_adair, csv(separator('|'), quote(''), maxlength(6000)));