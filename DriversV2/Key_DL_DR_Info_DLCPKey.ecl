import DriversV2, doxie;

base := DriversV2.Files_DL_Conv_Points_Base.Base_DR_Info;				   

export Key_DL_DR_Info_DLCPKey := index(base,
                                       {DLCP_Key},
						               {base},
						               '~thor_data400::key::dl2::'+doxie.Version_SuperKey+'::DR_Info_DLCP_Key');
