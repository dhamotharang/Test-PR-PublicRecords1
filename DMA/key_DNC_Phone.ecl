Import	Data_Services,Doxie,ut;

old_DNC_format := DMA.file_suppressionTPS.Building;
DMA.layout_suppressionTPS.Delta	tReformat2Delta(old_DNC_format	pInput)	:=
transform
    self.dt_effective_first := 0;
    self.dt_effective_last := 0;
    self.delta_ind := 0;
    self	:=	pInput;
end;

dDNCDelta	:=	project(old_DNC_format,tReformat2Delta(left));
export	key_DNC_Phone	:=	index(	dDNCDelta,
																	{PhoneNumber},
																	{PhoneNumber, dt_effective_first, dt_effective_last, delta_ind},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::DNC::'+ Doxie.Version_SuperKey +'::phone'
																);