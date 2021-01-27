import dx_DMA;
export	file_suppressionTPS	:=
module

	export	Base			:=	dataset('~thor_data400::base::suppression::tps',DMA.layout_suppressionTPS.Base,flat);
	
	dx_DMA.layouts.suppressionTPS.Building	tReformat2Bldg(Base	pInput)	:=
	transform
        self.dt_effective_first := 0;
        self.dt_effective_last := 0;
        self.delta_ind := 0;
		self	:=	pInput;
	end;
	
	dDNCBldg	:=	project(Base,tReformat2Bldg(left));
	
	export	Building	:=	dedup(distribute(dDNCBldg,hash32(PhoneNumber)),PhoneNumber,all,local);

end;