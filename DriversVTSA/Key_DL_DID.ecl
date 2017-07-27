import doxie;

base := dedup(Key_prep_DL_number(did != 0), all);

export Key_DL_DID := index(base,
						   {did},
						   {base},
						   constants.cluster + 'key::dl_VTSA::'+doxie.Version_SuperKey+'::dl_did');


