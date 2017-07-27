import ut;
basename:= cluster_name+'::base::appriss_bookings'; 
//basename:='~thor_data50::base::appriss_bookings'; 
export file_bookings_base := DATASET(basename,Appriss.Layout_Base_Bookings,flat);
