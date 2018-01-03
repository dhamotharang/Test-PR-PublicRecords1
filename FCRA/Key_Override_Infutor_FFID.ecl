import data_services;

ds := dataset('~thor_data400::base::override::fcra::qa::infutor', Layout_Override_Infutor, csv(separator('\t'),quote('\"')));

export Key_Override_Infutor_FFID := index(ds,{flag_file_id}, {ds},
																		data_services.data_location.prefix() + 'thor_data400::key::override::fcra::infutor::qa::ffid');