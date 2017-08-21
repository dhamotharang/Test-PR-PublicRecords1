import doxie;

base := Files().Titles_All.built(bdid <> 0 and did <> 0);				   

export Key_Best_MrkTitle_BDID_DID := index(base,
											{l_bdid := bdid,
											l_did  := did},
											{base},
											'~thor_data400::key::Marketing_Best::'+doxie.Version_SuperKey+'::Title_bdid_did');

