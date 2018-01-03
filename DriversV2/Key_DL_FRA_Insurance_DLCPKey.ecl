import DriversV2, doxie, data_services;

base := DriversV2.Files_DL_Conv_Points_Base.Base_FRA_Insurance;				   

export Key_DL_FRA_Insurance_DLCPKey := index(base,
                                             {DLCP_Key},
                                             {base},
                                             data_services.data_location.prefix() + 'thor_data400::key::dl2::'+doxie.Version_SuperKey+'::FRA_Insur_DLCP_Key');