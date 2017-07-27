import doxie;

base := Marketing_Best.File_Marketing_Best_All(bdid <> 0);				   

export Key_Marketing_Best_BDID := index(base,
										{l_bdid := bdid},
										{base},
										'~thor_data400::key::Marketing_Best::'+doxie.Version_SuperKey + '::bdid');

