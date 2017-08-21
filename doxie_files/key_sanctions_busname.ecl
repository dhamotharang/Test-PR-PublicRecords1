Import Data_Services, Ingenix_NatlProf, doxie, Data_Services;

base_file 	:= Ingenix_NatlProf.Basefile_Sanctions_Bdid(sanc_busnme<>'');
dedup_base	:= DEDUP(base_file, RECORD, ALL, LOCAL);

export key_sanctions_busname := index(dedup_base,
                                 {string120 s_sanc_busnme := sanc_busnme}, {did, sanc_id},
						   Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_busname_' + doxie.Version_SuperKey);
