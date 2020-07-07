import header,ut;
hf := header.File_HHID_Current;

export Key_HHID_Did := index(
	hf,	{hhid_relat, ver}, {did},
	ut.Data_Location.Person_header+'thor_data400::key::hhid_did_' + version_superkey, OPT);