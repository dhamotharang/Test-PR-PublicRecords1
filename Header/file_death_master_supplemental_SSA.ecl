import Data_Services,ut;
export file_death_master_supplemental_SSA := dataset(Data_Services.Data_location.prefix('Death')+'thor_data400::base::death_master_supplemental_SSA', header.layout_death_master_supplemental, flat);
