import ut;
basename:=ut.foreign_prod+'thor_200'+'::base::appriss_agency_delete_prepa'; 
export file_agency_delete_prepa := DATASET(basename,layout_prep_agency_deletes_rec,flat);