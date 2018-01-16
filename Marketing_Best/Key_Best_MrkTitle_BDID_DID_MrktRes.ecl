import doxie,Data_Services;

base := Marketing_Best.File_Marketing_Title_Restricted(bdid <> 0 and did <> 0);				   

export Key_Best_MrkTitle_BDID_DID_MrktRes := index(base,
											{l_bdid := bdid,
											l_did  := did},
											{base},
											Data_Services.Data_location.Prefix()+'thor_data400::key::Marketing_Best::'+doxie.Version_SuperKey+'::Title_bdid_did_MrktRes');
