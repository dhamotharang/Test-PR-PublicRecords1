Import Data_Services, Ingenix_NatlProf, doxie, Data_Services;

base_file 	:= Ingenix_NatlProf.Basefile_Sanctions_Bdid(sanc_busnme<>'');
slim_base	:= record
	base_file.sanc_busnme;
	base_file.did;
	base_file.sanc_id;
end;

// projected to slimmed layout and then dedup to reduce duplicates in the resulting key
dedup_base	:= DEDUP(project(base_file, slim_base), RECORD, ALL);

export key_sanctions_busname := index(dedup_base,
                                 {string120 s_sanc_busnme := sanc_busnme}, {did, sanc_id},
						   Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_busname_' + doxie.Version_SuperKey);
