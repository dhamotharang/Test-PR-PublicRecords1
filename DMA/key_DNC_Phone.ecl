Import	Data_Services,Doxie,ut;

export	key_DNC_Phone	:=	index(	DMA.file_suppressionTPS.Building,
																	{PhoneNumber},
																	{PhoneNumber, dt_effective_first, dt_effective_last, delta_ind},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::DNC::'+ Doxie.Version_SuperKey +'::phone'
																);