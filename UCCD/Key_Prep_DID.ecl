import doxie,data_services;

jfk := uccd.Joined_For_Key_DID;

/*
r := record, maxlength(150000)
	jfk;
end;
*/

export Key_Prep_DID := index(
	jfk, {s_did := did}, {jfk}, data_services.data_location.prefix() + 'thor_data400::key::ucc_did' + thorlib.wuid());
	