import Data_Services;
export File_SSN_Map := dataset (Data_Services.foreign_prod +'thor_data400::base::ssnissue2', layout_ssn_map, flat);

