import Ingenix_NatlProf, doxie, data_services;

base_file := Ingenix_NatlProf.file_sanctions_cleaned_dided_dates((unsigned6)did<>0);

export key_sanctions_did := index(base_file,
                                  {unsigned6 l_did := (unsigned6)did},
                                  {sanc_id},
                                  data_services.data_location.prefix() + 'thor_data400::key::ingenix_sanctions_did_' + doxie.Version_SuperKey);