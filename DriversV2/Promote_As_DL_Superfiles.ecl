promote_superfiles := sequential(FileServices.StartSuperFileTransaction(),
																 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::delete::As_DL_Mappers', true),
																 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::delete::As_DL_Mappers', 
																														DriversV2.Constants.cluster + 'in::dl2::Grandfather::As_DL_mappers',,true),
																 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::Grandfather::As_DL_mappers'),
																 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::Grandfather::As_DL_Mappers', 
																														DriversV2.Constants.cluster + 'in::dl2::father::As_DL_mappers',,true),
																 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::father::As_DL_mappers'),
																 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::father::As_DL_Mappers', 
																														DriversV2.Constants.cluster + 'in::dl2::As_DL_mappers',,true),										
																 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::As_DL_mappers'), 
																 FileServices.FinishSuperFileTransaction()
																);

EXPORT Promote_As_DL_Superfiles := promote_superfiles;