import doxie;
jfk := uccd.Joined_For_Key_DID;

export Key_DID := index(
	jfk, {s_did := did}, {jfk}, '~thor_data400::key::ucc_did_' + doxie.Version_SuperKey);