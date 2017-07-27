import ut;
basename:=cluster_name+'::base::appriss_bookings_prepb'; 
export file_bookings_prepb := DATASET(basename,layout_prep_booking_rec,flat);
