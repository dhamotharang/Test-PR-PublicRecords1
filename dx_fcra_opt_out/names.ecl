IMPORT data_services, doxie;

EXPORT names(string file_version = doxie.Version_SuperKey) := MODULE

    SHARED prefix               := data_services.data_location.Prefix('OptOut') + 'thor_data400::key::fcra::';

	EXPORT i_address            := prefix + 'optout::address_'      + file_version;
	EXPORT i_delta_rid          := prefix + 'optout::delta_rid_'    + file_version;
	EXPORT i_did                := prefix + 'optout::did_'          + file_version;
	EXPORT i_ssn                := prefix + 'optout::ssn_'          + file_version;

END;