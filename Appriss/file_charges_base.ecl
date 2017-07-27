import ut;
basename:=cluster_name+'::base::appriss_charges'; 
//basename:='~thor_data50::base::appriss_charges';
export file_charges_base := DATASET(basename,Layout_Base_Charges,flat);
