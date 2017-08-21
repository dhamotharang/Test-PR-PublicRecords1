import Data_Services,ut;
export file_death_master_supplemental := dataset(Data_Services.Data_location.prefix('Death')+'thor_data400::base::death_master_supplemental', header.layout_death_master_supplemental, flat);
