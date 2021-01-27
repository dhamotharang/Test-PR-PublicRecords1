export	file_suppressionTPS	:=
module

	export	Base			:=	dataset('~thor_data400::base::suppression::tps',DMA.layout_suppressionTPS.Base,flat);
	
	DMA.layout_suppressionTPS.Building	tReformat2Bldg(Base	pInput)	:=
	transform
		self	:=	pInput;
	end;
	
	dDNCBldg	:=	project(Base,tReformat2Bldg(left));
	
	export	Building	:=	dedup(distribute(dDNCBldg,hash32(PhoneNumber)),PhoneNumber,all,local);

end;
