promote_IN_Calbus := sequential( FileServices.StartSuperFileTransaction(),
																 FileServices.ClearSuperFile(Calbus.Constants.cluster + 'in::calbus::delete::Clean_updates::Superfile', true),
																 FileServices.AddSuperFile(Calbus.Constants.cluster + 'in::calbus::delete::Clean_updates::Superfile', 
																													 Calbus.Constants.cluster + 'in::calbus::Grandfather::Clean_updates::Superfile',,true),
																 FileServices.ClearSuperFile(Calbus.Constants.cluster + 'in::calbus::Grandfather::Clean_updates::Superfile'),
																 FileServices.AddSuperFile(Calbus.Constants.cluster + 'in::calbus::Grandfather::Clean_updates::Superfile', 
																													 Calbus.Constants.cluster + 'in::calbus::father::Clean_updates::Superfile',,true),
																 FileServices.ClearSuperFile(Calbus.Constants.cluster + 'in::calbus::father::Clean_updates::Superfile'),
																 FileServices.AddSuperFile(Calbus.Constants.cluster + 'in::calbus::father::Clean_updates::Superfile', 
																													 Calbus.Constants.cluster + 'in::calbus::Clean_updates::Superfile',,true),										
																 FileServices.ClearSuperFile(Calbus.Constants.cluster + 'in::calbus::Clean_updates::Superfile'), 
																 FileServices.FinishSuperFileTransaction()
															 );

promote_superfiles := if(nothor(fileservices.GetSuperFileSubCount(Calbus.Constants.cluster + 'in::calbus::Clean_updates::Superfile')) > 0, promote_IN_Calbus );

EXPORT Promote := promote_superfiles;