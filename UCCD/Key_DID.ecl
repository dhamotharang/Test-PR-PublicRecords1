import data_services;

jfk := uccd.Joined_For_Key_DID;

export Key_DID := index(
	jfk, {s_did := did}, {jfk}, data_services.data_location.prefix() + 'thor_data400::key::ucc_did_' + uccd.key_version);