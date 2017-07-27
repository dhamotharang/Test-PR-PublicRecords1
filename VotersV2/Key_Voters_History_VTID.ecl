import doxie;

base := VotersV2.File_Voters_VoteHistory_base;				   

export Key_Voters_History_VTID := index(base,
																			 {vtid},
																			 {base},
																			 '~thor_data400::key::voters::'+doxie.Version_SuperKey+'::History_vtid');

 