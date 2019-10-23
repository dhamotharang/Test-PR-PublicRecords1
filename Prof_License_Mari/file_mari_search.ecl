import ut, data_services ;

// export file_mari_search := dataset('~thor_data400::base::proflic_mari::search',Prof_License_Mari.layouts.final,thor);

input_search_file :=  dataset('~thor_data400::base::proflic_mari::search',Prof_License_Mari.layouts.final,thor);

export file_mari_search := input_search_file(mari_rid != 4135678462 or trim(std_source_upd) != 'S0280');
