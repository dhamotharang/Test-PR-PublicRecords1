import DriversV2, doxie, data_services;

base := DriversV2.Files_DL_Conv_Points_Base.Base_Suspension;				   

export Key_DL_Suspension_DLCPKey := index(base,
						                  {DLCP_Key},
						                  {base},
						                  data_services.data_location.prefix() + 'thor_data400::key::dl2::'+doxie.Version_SuperKey+'::Suspension_DLCP_Key');
