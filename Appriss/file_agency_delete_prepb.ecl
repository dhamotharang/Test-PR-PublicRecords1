import ut, Data_Services;
basename:=data_services.data_location.prefix() + 'thor_200'+'::base::appriss_agency_delete_prepb'; 
export file_agency_delete_prepb := DATASET(basename,layout_prep_agency_deletes_rec,flat);
