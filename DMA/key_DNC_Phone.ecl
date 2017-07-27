Import	Data_Services,Doxie,ut;

export	key_DNC_Phone	:=	index(	DMA.file_suppressionTPS.Building,
																	{PhoneNumber},
																	{PhoneNumber},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::DNC::'+ Doxie.Version_SuperKey +'::phone'
																);