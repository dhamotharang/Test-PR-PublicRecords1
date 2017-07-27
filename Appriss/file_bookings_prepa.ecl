basename:=cluster_name+'::base::appriss_bookings_prepa'; 

export file_bookings_prepa := DATASET(basename,layout_prep_booking_rec,flat);
