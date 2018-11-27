promote_IN_txbus := sequential( FileServices.StartSuperFileTransaction(),
																 FileServices.ClearSuperFile(txbus.Constants.cluster + 'in::txbus::delete::Clean_updates::Superfile', true),
																 FileServices.AddSuperFile(txbus.Constants.cluster + 'in::txbus::delete::Clean_updates::Superfile', 
																													 txbus.Constants.cluster + 'in::txbus::Grandfather::Clean_updates::Superfile',,true),
																 FileServices.ClearSuperFile(txbus.Constants.cluster + 'in::txbus::Grandfather::Clean_updates::Superfile'),
																 FileServices.AddSuperFile(txbus.Constants.cluster + 'in::txbus::Grandfather::Clean_updates::Superfile', 
																													 txbus.Constants.cluster + 'in::txbus::father::Clean_updates::Superfile',,true),
																 FileServices.ClearSuperFile(txbus.Constants.cluster + 'in::txbus::father::Clean_updates::Superfile'),
																 FileServices.AddSuperFile(txbus.Constants.cluster + 'in::txbus::father::Clean_updates::Superfile', 
																													 txbus.Constants.cluster + 'in::txbus::qa::Clean_updates::Superfile',,true),										
																 FileServices.ClearSuperFile(txbus.Constants.cluster + 'in::txbus::qa::Clean_updates::Superfile'), 
																 FileServices.ClearSuperFile(txbus.Constants.cluster + 'in::txbus::Raw::Superfile'), 
																 FileServices.FinishSuperFileTransaction()
															 );

promote_superfiles := if(nothor(fileservices.GetSuperFileSubCount(txbus.Constants.cluster + 'in::txbus::qa::Clean_updates::Superfile')) > 0, promote_IN_txbus );

EXPORT Promote := promote_superfiles;