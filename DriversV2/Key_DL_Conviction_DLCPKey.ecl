import DriversV2, doxie, data_services;

base := DriversV2.Files_DL_Conv_Points_Base.Base_Conviction;				   

export Key_DL_Conviction_DLCPKey := index(base,
						                  {DLCP_Key},
						                  {base},
						                  data_services.data_location.prefix() + 'thor_data400::key::dl2::'+doxie.Version_SuperKey+'::Conviction_DLCP_Key');

