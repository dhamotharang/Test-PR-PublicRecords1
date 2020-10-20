IMPORT data_services, doxie;

EXPORT names(string file_version = doxie.Version_SuperKey) := MODULE

    SHARED prefix           := data_services.data_location.Prefix('Patriot') + 'thor_data400::key::';

	EXPORT i_delta_rid      := prefix + 'patriot_file::delta_rid_' + file_version;

END;