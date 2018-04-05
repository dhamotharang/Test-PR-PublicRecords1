import Doxie,suppress,data_services;

export File_New_Suppression := DATASET(data_services.foreign_prod+'thor_data400::base::new_suppression_file', Suppress.Layout_New_Suppression,THOR);