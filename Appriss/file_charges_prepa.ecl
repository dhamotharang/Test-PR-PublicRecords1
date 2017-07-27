basename:=cluster_name+'::base::appriss_charges_prepa'; 

export file_charges_prepa := DATASET(basename,layout_prep_charges_rec,flat);
