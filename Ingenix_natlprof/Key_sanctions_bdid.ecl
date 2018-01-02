import Ingenix_NatlProf, doxie, data_services;

base_file := Ingenix_NatlProf.Sanctioned_providers_Bdid(bdid<>0);

export key_sanctions_bdid := index(base_file,
                                 {bdid},
						   {sanc_id},
						   data_services.data_location.prefix() + 'thor_data400::key::ingenix_sanctions_bdid_' + doxie.Version_SuperKey);