import doxie, data_services;

h := File_Household;

export Key_Household := INDEX(File_Household,
															{h.lname,h.prim_name,h.zip,h.st,h.prim_range,h.sec_range},{h},
															data_services.data_location.prefix() + 'thor_data400::key::hhid_'+doxie.Version_SuperKey);