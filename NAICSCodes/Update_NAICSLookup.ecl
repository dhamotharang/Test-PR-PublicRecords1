import NAICSCodes;

export Update_NAICSLookup(

	 string																  pversion
	,dataset(Layouts.Sprayed_Input)	        pSprayedFile       = Files().Input.NAICS.using																												
	,dataset(Layouts.Sprayed_Input_DnbDmi	)	pSprayedDnbDmiFile = Files().Input.DnbDmi.using 
	,boolean																pShouldUpdate	     = _Flags.UpdateExists	
) :=
function

  dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pSprayedDnbDmiFile, pversion);
	
	return dStandardizedInputFile;

end;