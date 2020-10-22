IMPORT data_services, doxie;

EXPORT names(string file_version = doxie.Version_SuperKey) := MODULE

    SHARED prefix                       := data_services.data_location.Prefix('Patriot') + 'thor_data400::key::';

	EXPORT i_patriot_file_delta_rid     := prefix + 'patriot_file::delta_rid_' + file_version;
	EXPORT i_annotated_names_delta_rid  := prefix + 'annotated_names::delta_rid_' + file_version;
	EXPORT i_baddids_delta_rid          := prefix + 'baddids::delta_rid_' + file_version;

END;