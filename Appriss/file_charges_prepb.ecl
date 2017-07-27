import ut;
basename:=cluster_name+'::base::appriss_charges_prepb'; 
export file_charges_prepb := DATASET(basename,layout_prep_charges_rec,flat);
