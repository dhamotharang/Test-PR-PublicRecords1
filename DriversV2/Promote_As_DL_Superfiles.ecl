promote_DL_superfiles := sequential( FileServices.StartSuperFileTransaction(),
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
																
promote_Conv_superfiles := sequential( FileServices.StartSuperFileTransaction(),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_convictions', true),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_convictions', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions',,true),										
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions'), 
																			 FileServices.FinishSuperFileTransaction()
																			);

promote_Susp_superfiles := sequential( FileServices.StartSuperFileTransaction(),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_suspension', true),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_suspension', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_suspension',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_suspension'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_suspension', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_suspension',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_suspension'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_suspension', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::as_suspension',,true),										
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_suspension'), 
																			 FileServices.FinishSuperFileTransaction()
																			);
																			
promote_DR_Info_superfiles := sequential(FileServices.StartSuperFileTransaction(),
																				 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_dr_info', true),
																				 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_dr_info', 
																																		DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_dr_info',,true),
																				 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_dr_info'),
																				 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_dr_info', 
																																		DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_dr_info',,true),
																				 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_dr_info'),
																				 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_dr_info', 
																																		DriversV2.Constants.cluster + 'in::dl2::convpoints::as_dr_info',,true),										
																				 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_dr_info'), 
																				 FileServices.FinishSuperFileTransaction()
																				);
																				
promote_Acci_superfiles := sequential( FileServices.StartSuperFileTransaction(),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_accident', true),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_accident', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_accident',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_accident'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_accident', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_accident',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_accident'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_accident', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::as_accident',,true),										
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_accident'), 
																			 FileServices.FinishSuperFileTransaction()
																			);
																			
promote_Insu_superfiles := sequential( FileServices.StartSuperFileTransaction(),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_insurance', true),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_insurance', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_insurance',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_insurance'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_insurance', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_insurance',,true),
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_insurance'),
																			 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_insurance', 
																																	DriversV2.Constants.cluster + 'in::dl2::convpoints::as_insurance',,true),										
																			 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_insurance'), 
																			 FileServices.FinishSuperFileTransaction()
																			);

promote_Conv_Rest_superfiles := sequential(FileServices.StartSuperFileTransaction(),
																					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_convictions_restricted', true),
																					 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::delete::as_convictions_restricted', 
																																			DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions_restricted',,true),
																					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions_restricted'),
																					 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::Grandfather::as_convictions_restricted', 
																																			DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions_restricted',,true),
																					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions_restricted'),
																					 FileServices.AddSuperFile( DriversV2.Constants.cluster + 'in::dl2::convpoints::father::as_convictions_restricted', 
																																			DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions_restricted',,true),										
																					 FileServices.ClearSuperFile(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions_restricted'), 
																					 FileServices.FinishSuperFileTransaction()
																					);
																					
promote_superfiles := parallel(if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::As_DL_mappers')) > 0, promote_DL_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions')) > 0, promote_Conv_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_suspension')) > 0, promote_Susp_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_dr_info')) > 0, promote_DR_Info_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_accident')) > 0, promote_Acci_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_insurance')) > 0, promote_Insu_superfiles),
															 if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.cluster + 'in::dl2::convpoints::as_convictions_restricted')) > 0, promote_Conv_Rest_superfiles)
															);

EXPORT Promote_As_DL_Superfiles := promote_superfiles;