jfk := uccd.Joined_For_Key_DID;

/*
r := record, maxlength(150000)
	jfk;
end;
*/

export Key_Prep_DID := index(
	jfk, {s_did := did}, {jfk}, '~thor_data400::key::ucc_did' + thorlib.wuid());
	