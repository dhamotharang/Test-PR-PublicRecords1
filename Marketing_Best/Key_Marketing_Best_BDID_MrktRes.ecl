import doxie,Data_Services;

base := Marketing_Best.File_Marketing_Best_Restricted(bdid <> 0);				   

export Key_Marketing_Best_BDID_MrktRes := index(base,
										{l_bdid := bdid},
										{base},
										Data_Services.Data_location.Prefix()+'thor_data400::key::Marketing_Best::'+doxie.Version_SuperKey+'::bdid_MrktRes');