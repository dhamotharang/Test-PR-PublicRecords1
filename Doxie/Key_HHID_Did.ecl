import header;
hf := header.File_HHID_Current;

export Key_HHID_Did := index(
	hf,	{hhid_relat, ver}, {did},
	'~thor_data400::key::hhid_did_' + version_superkey, OPT);