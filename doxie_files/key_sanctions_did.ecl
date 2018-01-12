Import Data_Services, Ingenix_NatlProf, doxie, Data_Services;

base_file := Ingenix_NatlProf.Basefile_Sanctions_Bdid((unsigned6)did<>0);
slim_base	:= record
	base_file.did;
	base_file.sanc_id;
end;
dedup_base	:= dedup(project(base_file, slim_base), record, all, local);

export key_sanctions_did := index(dedup_base,//base_file,
                                 {unsigned6 l_did := (unsigned6)did},
						   {sanc_id},
						   Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_did_' + doxie.Version_SuperKey);
